var ledger_size_inc = 500;

ledger = ds_grid_create(ledger_size_inc, 3);
read_ahead_time = right_stick_obj.y / note_speed / 60;
playhead = 0;

var tab = file_text_open_read(working_directory + "flicker_tab.txt");

global.bpm = file_text_read_real(tab);

for (var i = 0; !file_text_eof(tab); ++i)
{
	if (i >= ds_grid_height(ledger))
		ds_grid_resize(ledger, i + ledger_size_inc, 3);
		
	ds_grid_set(ledger, i, 0, file_text_read_real(tab));
	ds_grid_set(ledger, i, 1, file_text_read_real(tab));
	ds_grid_set(ledger, i, 2, file_text_read_real(tab));
}
note_count = i + 1;
ds_grid_resize(ledger, note_count, 3);
file_text_close(tab);

song = flicker;
//song = audio_play_sound(flicker, 1, false);