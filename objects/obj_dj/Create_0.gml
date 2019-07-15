scr_build_ledger("flicker_beat.chart")

read_ahead_time = right_stick_obj.y / note_speed / 60;

playhead = 0;
streak = 0;

song = snd_flicker;
song_index = 0;
//song_index = audio_play_sound(song, 1, false);