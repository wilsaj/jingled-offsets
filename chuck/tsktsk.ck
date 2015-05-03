//tsk tsk

Gain master => dac;

Shakers shaker => master;
128 => shaker.objects;

.75 => float duration_seconds;
if(me.args() > 0) {
    Std.atof(me.arg(0)) => duration_seconds;
}
duration_seconds::second => dur quarternote;

Std.atoi(me.arg(1)) => shaker.preset;
Std.atof(me.arg(2)) => shaker.freq;

while (true)
{
    Math.random2(0, 3) => int tums;
    for(0 => int t; t < 4; t++)
    {
        if(tums == t)
        {
            1 => shaker.energy;
        }

        .5 => shaker.energy;
        quarternote/8 => now;
    }
    1 => shaker.energy;
}
