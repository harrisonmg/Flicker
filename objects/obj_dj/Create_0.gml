scr_build_ledger("flicker_beat.chart")

read_ahead_time = (right_stick_obj.y + note_alignment) / note_speed / 60;

// check if notes start in chart before they'd have time to move down the screen
var first_note_time = ds_grid_get(ledger, 0, ledger_index.NOTE_TIME);
if (first_note_time < read_ahead_time)
	pre_song_time = read_ahead_time - first_note_time;
else
	pre_song_time = 0;

pre_song_timer = 0;
playhead = 0;
streak = 0;

song = snd_flicker;
song_index = 0;