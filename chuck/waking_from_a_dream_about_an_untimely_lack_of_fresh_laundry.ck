// "waking from a dream about an untimely lack of fresh laundry to discover that it is the start of a three-day weekend"

// sound network
SinOsc sin => dac;
SqrOsc sqr => dac;
SawOsc saw => dac;
TriOsc tri => dac;

// some basic note frequencies
110 => float a;
116.54 => float ab;
123.47 => float b;
130.81 => float c;
138.59 => float cd;
146.83 => float d;
155.56 => float de;
164.81 => float e;
174.61 => float f;
185 => float fg;
196 => float g;
207.65 => float ga;

0 => int alarm;

0 => sin.gain;
0 => sqr.gain;
0 => saw.gain;
0 => tri.gain;


// main loop for the song - basically each iteration of i will be 200 ms
// with a 1 second fadeout at the end
for(0 => int i; i < 147; i++) {
    // when special is 0 we just move time forward for 200 ms, when special is
    // something else we'll do crazy things (see bottom of the loop)
    0 => int special;
    0 => float specialFreq;

    // alarm switches from 0 to 1, it's used to create a
    // repeating beat in certain parts
    if (alarm == 0) {
        1 => alarm;
    }
    else {
        0 => alarm;
    }

    if (0 < i) {
        .1 => sqr.gain;
        f * 4 => sqr.freq;
    }
    if (4 < i) {
        .2 => sqr.gain;
        b * 4 => sqr.freq;
    }
    if (8 < i) {
        .3 => sqr.gain;
        e * 8 => sqr.freq;
    }
    if (9 < i) {
        .4 => sqr.gain;
        a * 4 => saw.freq;
        d * 2 => sqr.freq;
    }
    if (12 < i) {
        a * 4 => saw.freq;
        fg => sqr.freq;
    }
    if (21 < i) {
        alarm * .8 => saw.gain;
        a * 4 => sqr.freq;
        a * 2 => saw.freq;
    }
    if (30 < i) {
        f * 4 => sqr.freq;
    }
    if (33 < i) {
        g * 4 => sqr.freq;
    }
    if (36 < i) {
        e * 4 => sqr.freq;
    }
    if (39 < i) {
        d * 4 => sqr.freq;
    }
    if (42 < i) {
        a * 4 => sqr.freq;
    }
    if (43 < i) {
        f * 2 => sqr.freq;
    }
    if (44 < i) {
        g * 2 => sqr.freq;
    }
    if (45 < i) {
        a * 2 => sqr.freq;
    }
    if (46 < i) {
        e * 4 => sqr.freq;
    }
    if (47 < i) {
        a * 8 => sqr.freq;
    }
    if (49 < i) {
        d * 4 => sqr.freq;
    }
    if (50 < i) {
        f * 4 => sin.freq;
        cd * 2 => saw.freq;
        1 => sin.gain;
        0 => sqr.gain;
    }
    if (55 < i) {
        g * 4 => sin.freq;
    }
    if (59 < i) {
        fg * 4 => sin.freq;
    }
    if (60 < i) {
        b * 4 => sin.freq;
    }
    if (63 < i) {
        a * 8 => sin.freq;
    }
    if (66 < i) {
        a * 4 => sin.freq;
    }
    if (68 < i) {
        cd * 4 => sin.freq;
    }
    if (69 < i) {
        cd * 8 => sin.freq;
    }
    if (70 < i) {
        g * 4 => sin.freq;
    }
    if (72 < i) {
        d * 4 => sin.freq;
        f * 8 => saw.freq;
    }
    if (74 < i) {
        a => saw.freq;
        0 => sin.gain;
    }

    // waking
    if (75 < i) {
        0 => sqr.gain;
        0 => saw.gain;
    }

    if (77 < i) {
        1 => sin.gain;
        2 => special;
        d * 4 => specialFreq;
    }
    if (78 < i) {
        a * 8 => specialFreq;
    }
    if (79 < i) {
        g * 4 => specialFreq;
    }
    if (80 < i) {
        f * 2 => specialFreq;
    }
    if (81 < i) {
        1 => special;
        f * 2 => specialFreq;
    }
    if (82 < i) {
        g * 4 => specialFreq;
    }
    if (83 < i) {
        a * 8 => specialFreq;
    }
    if (84 < i) {
        d * 4 => specialFreq;
    }
    if (85 < i) {
        0 => special;
        0 => sin.gain;
    }

    if (87 < i) {
        // an increasing louder set of alarm beeps
        a * 2 => saw.freq;
        alarm * ((i - 87) / 10.0) => saw.gain;
    }

    if (97 < i) {
        // hit the snooze
        0 => saw.gain;
    }

    if (102 < i) {
        1 => tri.gain;
        a * 2 => tri.freq;
    }
    if (104 < i) {
        g * 2 => tri.freq;
    }
    if (105 < i) {
        d * 2 => tri.freq;
    }
    if (106 < i) {
        g * 2 => tri.freq;
    }

    if (107 < i) {
        1 => sin.gain;
        d * 4 => sin.freq;
    }
    if (108 < i) {
        c * 4 => sin.freq;
    }
    if (109 < i) {
        f * 2 => sin.freq;
    }
    if (110 < i) {
        a * 4 => sin.freq;
    }
    if (112 < i) {
        a * 4 => tri.freq;
        e * 4 => sin.freq;
    }
    if (114 < i) {
        cd * 4 => tri.freq;
        fg * 4 => sin.freq;
    }
    if (115 < i) {
        a * 8 => sin.freq;
    }
    if (116 < i) {
        cd * 4 => sin.freq;
    }
    if (118 < i) {
        fg * 4 => tri.freq;
        a * 4 => sin.freq;
    }
    if (119 < i) {
        d * 4 => tri.freq;
    }
    if (120 < i) {
        a * 8 => tri.freq;
    }
    if (121 < i) {
        fg * 2 => tri.freq;
    }
    if (122 < i) {
        d * 2 => tri.freq;
        a * 8 => sin.freq;
    }
    if (123 < i) {
        fg * 8 => sin.freq;
    }
    if (124 < i) {
        fg * 2 => tri.freq;
        a * 8 => sin.freq;
    }
    if (126 < i) {
        fg * 4 => sin.freq;
    }
    if (127 < i) {
        e * 4 => sin.freq;
    }
    if (128 < i) {
        a * 4 => sin.freq;
    }
    if (130 < i) {
        fg * 4 => tri.freq;
        c * 2 => sin.freq;
    }
    if (131 < i) {
        d * 4 => tri.freq;
    }
    if (132 < i) {
        a * 8 => tri.freq;
    }
    if (134 < i) {
        g * 4 => tri.freq;
    }
    if (136 < i) {
        d * 4 => sin.freq;
        fg * 4 => tri.freq;
    }
    if (138 < i) {
        d * 8 => tri.freq;
    }
    if (139 < i) {
        a * 8 => tri.freq;
    }
    if (140 < i) {
        fg * 8 => tri.freq;
    }

    // fade out for 1 sec - gradually adjust the gain down from 1 to 0
    if (i == 146) {
        for (1 => int j; j < 200; j++) {
            1.0 - (j / 200.0) => float gain;
            gain => sin.gain;
            gain => tri.gain;
            5::ms => now;
        }
    }

    // when special == 0, just let the oscillators sing for 200 ms
    if (special == 0) {
        200::ms => now;
    }
    // otherwise go to crazy town; basically we just take a base frequency and fuzz into or out of it
    else if (special > 0) {
        // this variable will hold the amount of the freq we want to add/subtract by per ms
        0 => float modifier;
        // this variable will be an an oscillating series of -1 and 1 so we
        // can switch from adding and subtracting
        1 => int updown;
        // the amount of distance from the base frequency to go per millisecond
        2 => float multiplier;
        for (1 => int j; j < 200; j++) {
            // updown switches from -1 to 1 each time the loop is executed
            updown * -1 => updown;

            // fuzz out away from the base freq
            if (special == 1) {
                j * updown * multiplier => modifier;
            }
            // fuzz in towards the base freq
            else if (special == 2) {
                (200 - j) * updown * multiplier => modifier;
            }

            specialFreq + modifier => sin.freq;
            1::ms => now;
        }
    }
}
