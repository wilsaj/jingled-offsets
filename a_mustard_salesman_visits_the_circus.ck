//"a mustard salesman visits the circus hoping to make inroads with whoever is in charge of concessions"


// sound network
SinOsc sins[3];
Pan2 pans[3];
SawOsc melodyOsc;
SqrOsc under;
TriOsc drum;

// set up the sin oscs
for(0 => int i; i < sins.cap(); i++)
{
    0 => sins[i].freq;
    0 => sins[i].gain;
    sins[i] => pans[i] => dac;
}

// sin[0] will come from the left
// sin[1] will come from the right
// sin[2] from the middle
-.75 => pans[0].pan;
.75 => pans[1].pan;

0 => drum.freq;
0 => drum.gain;
drum => dac;

0 => under.freq;
under => Pan2 p => dac;

0 => melodyOsc.freq;
0 => melodyOsc.gain;
melodyOsc => dac;
float melodyNote;
float previousMelodyNote;

1 => float maxVol;
1 => float melodyVolFade;

int drums[4];
int chord[6];

// dorian scale
[0, 2, 3, 5, 7, 9, 10, 12, 14, 15, 17, 19, 21, 22, 24] @=> int scale[];

// the melody part
// it's a two-dimensional array which is just an array of arrays
// the piece is in 3/4 (ish) and each array corresponds to a measure
// if a single note, then it'll be held for the entire measure
// all values are offset by 50, and -50 is silent (freq 0)
[
[-50],
[-50],
[-50],
[-50],
[-50],
[-50],
[-50],
[24],
[12],
[22, 22, 21],
[0],
[22, 22, 21],
[15],
[9, 9, 10],
[15],
[0],
[24],
[-2, 0, 5],
[19, 12, 15],
[12, 15, 19],
[36],
[24, 19, 9],
[34, 34, 33],
[24],
[34, 34, 33],
[12, 14, 19],
[10, 10, 9],
[5, 5, -2],
[0, -12, -5],
[-2, -2, 5],
[-7, -2, 5],
[-2, -2, 17],
[19, 19, 14],
[12],
[12],
[12],
[12],
[12],
[12],
[12],
[12],
[-50]
] @=> int melody[][];

int subMelody[];

// quarter note duration
.25::second => dur quarter;

// base of d
50 => int base;


// 40 measures of 3/4 (.75 seconds each)
for(0 => int t; t < 40; t++)
{
    // each measure will get a randomized chord
    // chord is an array of int values 0-7 ascending
    int chord[3];
    Math.random2(0,5) => chord[0];
    Math.random2(chord[0] + 1, 6) => chord[1];
    Math.random2(chord[1], 7) => chord[2];

    // we'll add a bouncy bassy square wave for the first note of the chord
    Std.mtof(scale[chord[0]] + (base - 24)) => under.freq;

    if(t < melody.cap())
    {
        melody[t] @=> subMelody;
    }
    else
    {
        [-50] @=> subMelody;
        0 => melodyOsc.freq;
    }

    // this loop handles each quarter note
    for(0 => int i; i < 3; i++)
    {
        // chord notes are 0-7, so grab corresponding note off the
        // scale array and then bump it up to the around 50, plus or
        // minus an octave
        scale[chord[i]] + (base + (Math.random2(-1, 1) * 12)) => int note;
        Std.mtof(note) => sins[i].freq;

        // fade in and out at the ends of the song
        if (t < 4)
        {
            (t + 1) / 4 => maxVol;
        }
        if (t >= 34){
            (39.0 - t) / 5 => maxVol;
        }
        else {
            1 => maxVol;
        }
        if(maxVol > 0)
        {
            maxVol * .2 => sins[i].gain;
        }


        if (i < subMelody.cap())
        {
            if(subMelody[i] <= -50)
            {
                0 => melodyNote;
            }
            else
            {

                Std.mtof(subMelody[i] + base) => melodyNote;
            }
            if (melodyNote != previousMelodyNote)
            {
                melodyNote => melodyOsc.freq;
            }
            melodyNote => previousMelodyNote;
        }

        // fade out melody at the end
        if (t >= 37)
        {
            0 => melodyVolFade;
        }
        else if (t >= 32)
        {
            ((36.0 - t) * 3 + (2 - i)) / 15 => melodyVolFade;
        }
        else {
            1 => melodyVolFade;
        }
        .08 * melodyVolFade => melodyOsc.gain;


        // drums array will hold the pattern of sixteenth notes to play
        // 1 is a drumbeat, 0 is a rest
        if (i == 2)
        {
            if ((t % 5) == 2)
            {
                [1, 1, 1, 1] @=> drums;
            }
            else
            {
                [0, 0, 1, 0] @=> drums;
            }
        }
        else {
            [1, 0, 0, 0] @=> drums;
        }

        // play notes / drums
        for(0 => int b; b < drums.cap(); b++)
        {
            // pan and fade for the bassy under note
            (13.0 - ((i+1) * chord.cap() + (b+1))) / 12 => float u_pan;
            (u_pan * 2) - 1 => p.pan;
            if (maxVol > 0)
            {
                (u_pan / 20) * maxVol => under.gain;
                .75 * maxVol => drum.gain;
            }

            // drum beat is implemented by playing for the first 1/3 of
            // a sixteenth note, then silence for the last 2/3 of
            // sixteenth note - it's weird but it kinda works
            if (drums[b] == 1)
            {
                Std.mtof(40) => drum.freq;
            }
            quarter / 12 => now;
            if (drums[b] == 1)
            {
                0 => drum.freq;
            }
            (2 * quarter) / 12 => now;
        }
    }

    // silence the; setting freq to 0 avoids snap that happens when setting gain to 0
    for(0 => int i; i < chord.cap(); i++)
    {
        0 => sins[i].freq;
        0 => drum.freq;
    }
}
