/// @desc Read a song chart and build a ledger from it.
/// @arg chart_name

var chart_name = argument0;

var ledger_size_inc = 500;

ledger = ds_grid_create(ledger_size_inc, 3);

var chart = file_text_open_read(working_directory + chart_name);

var chart_type = file_text_read_real(chart);
if (chart_type == chart_types.TIME)
{
	var bpm = file_text_read_real(chart);
	
	for (var i = 0; !file_text_eof(chart); ++i)
	{
		if (i >= ds_grid_height(ledger))
			ds_grid_resize(ledger, i + ledger_size_inc, 3);
		
		ds_grid_set(ledger, i, 0, file_text_read_real(chart));
		ds_grid_set(ledger, i, 1, file_text_read_real(chart));
		ds_grid_set(ledger, i, 2, file_text_read_real(chart));
	}
	note_count = i + 1;
	
	// copy current chart for chart mode
	if (global.game_mode == game_modes.CHART)
	{
		working_chart_type = chart_types.TIME;
		working_chart = file_text_open_write(working_directory + date_current_datetime() + ".chart");
		file_text_write_real(working_chart, chart_types.TIME);
		file_text_writeln(working_chart);
		file_text_write_real(working_chart, bpm);
		file_text_writeln(working_chart);
		file_text_writeln(working_chart);
	}
}
else if (chart_type == chart_types.BEAT)
{
	var bpm = file_text_read_real(chart);
	var beat_length = 60 / bpm;
	var sixteenth_length = beat_length / 4;
	var offset = file_text_read_real(chart);
	
	for (var i = 0; !file_text_eof(chart); ++i)
	{
		if (i >= ds_grid_height(ledger))
			ds_grid_resize(ledger, i + ledger_size_inc, 3);
			
		var note_time = offset + (file_text_read_real(chart) - 1) * beat_length + (file_text_read_real(chart) - 1) * sixteenth_length;
		
		ds_grid_set(ledger, i, 0, note_time);
		ds_grid_set(ledger, i, 1, file_text_read_real(chart));
		ds_grid_set(ledger, i, 2, file_text_read_real(chart));
	}
	note_count = i + 1;

	// copy current chart for chart mode
	if (global.game_mode == game_modes.CHART)
	{
		working_chart_type = chart_types.BEAT;
		working_chart = file_text_open_write(working_directory + string(date_current_datetime()) + ".chart");
		file_text_write_real(working_chart, chart_types.BEAT);
		file_text_writeln(working_chart);
		file_text_write_real(working_chart, bpm);
		file_text_writeln(working_chart);
		file_text_write_real(working_chart, offset);
		file_text_writeln(working_chart);
		file_text_writeln(working_chart);
	}
}

ds_grid_resize(ledger, note_count, 3);
file_text_close(chart);