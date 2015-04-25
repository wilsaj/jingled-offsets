REC_AUTO := tmp/rec-auto.ck
REC := tmp/rec.ck

all: mp3/waking_from_a_dream_about_an_untimely_lack_of_fresh_laundry.mp3

clean:
	rm -rf mp3/*
	rm -rf wav/*


${REC}:
	mkdir -p $(dir $@)
	curl 'http://chuck.cs.princeton.edu/doc/examples/basic/rec.ck' -o $@.download
	mv $@.download $@


mp3/%.mp3: wav/%.wav
	mkdir -p $(dir $@)
	lame --preset 320 $< $@


# kinda jank, don't work great
wav/%.wav: %.ck ${REC}
	mkdir -p $(dir $@)
	chuck $< ${REC}:$@
