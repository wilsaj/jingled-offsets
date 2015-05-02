REC := rec-stereo-duration.ck

.PHONY: chucks

all: chucks


chucks: \
	mp3/waking_from_a_dream_about_an_untimely_lack_of_fresh_laundry.mp3 \
	mp3/a_mustard_salesman_visits_the_circus.mp3


clean:
	rm -rf mp3/*
	rm -rf wav/*


mp3/%.mp3: wav/%.wav
	mkdir -p $(dir $@)
	lame --preset 320 $< $@


wav/waking_from_a_dream_about_an_untimely_lack_of_fresh_laundry.wav: waking_from_a_dream_about_an_untimely_lack_of_fresh_laundry.ck
	mkdir -p $(dir $@)
	chuck $< ${REC}:$@:30

wav/a_mustard_salesman_visits_the_circus.wav: a_mustard_salesman_visits_the_circus.ck
	mkdir -p $(dir $@)
	chuck $< ${REC}:$@:30
