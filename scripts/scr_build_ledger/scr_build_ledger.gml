/// @desc Read a song chart and build a ledger from it, return the song asset.
/// @arg chart file name

var chart_filename = argument0;
var ledger_size_inc = 500;
ledger = ds_grid_create(ledger_size_inc, ledger_index.LEDGER_HEIGHT);
var chart = file_text_open_read(working_directory + chart_filename);

chart = scr_clean_chart(chart);

var song_filename = file_text_read_string(chart);
var chart_type = file_text_read_real(chart);
note_speed = file_text_read_real(chart); 
global.bpm = file_text_read_real(chart);

if (chart_type == chart_types.BEAT)
{
	var beat_length = 60 / global.bpm;
	var thirty2nd_length = beat_length / 8;
	var offset = file_text_read_real(chart);
}

var note_time;
for (var i = 0; !file_text_eof(chart); ++i)
{	
	// resize ledger if not big enough
	if (i >= ds_grid_width(ledger))
		ds_grid_resize(ledger, i + ledger_size_inc, ledger_index.LEDGER_HEIGHT);
		
	// support both times and beats
	if (chart_type == chart_types.BEAT)
	{
		note_time = offset + (file_text_read_real(chart) - 1) * beat_length + (file_text_read_real(chart) - 1) * thirty2nd_length;
	}
	else
	{
		note_time = file_text_read_real(chart)
	}
	
	// populate ledger
	ds_grid_set(ledger, i, ledger_index.NOTE_TIME, note_time);
	ds_grid_set(ledger, i, ledger_index.STICK, file_text_read_real(chart));
	ds_grid_set(ledger, i, ledger_index.NOTE_TYPE, file_text_read_real(chart));
	ds_grid_set(ledger, i, ledger_index.NOTE_DIR, file_text_read_real(chart));
	
	if file_text_eof(chart) break;
}

note_count = i;
ds_grid_resize(ledger, i, ledger_index.LEDGER_HEIGHT);
file_text_close(chart);

return asset_get_index(song_filename);