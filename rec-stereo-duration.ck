// chuck this with other shreds to record to file for some number of seconds
// example> chuck foo.ck bar.ck rec-stereo-duration.ck:<filename.wav>:<duration_in_seconds>

// arguments: rec:<filename.wav>:<duration_in_seconds>

// get name
me.arg(0) => string filename;

// get duration
me.arg(1) => Std.atoi => int duration;

// pull samples from the dac
dac => Gain g => WvOut2 w => blackhole;

// this is the output file name
filename => w.wavFilename;
<<<"writing to file:", "'" + w.filename() + "'", "duration:", duration>>>;

// any gain you want for the output
1 => g.gain;

// temporary workaround to automatically close file on remove-shred
null @=> w;

// record for <duration> seconds
duration::second => now;
