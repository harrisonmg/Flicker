/// @desc Check for a flick and respond with the appropriate actions.

flick_this_frame = false;
gp_connected = gamepad_is_connected(global.gp_index);

// up flick
if (not up_flick)
{
	if ((gp_connected and gamepad_axis_value(global.gp_index, vertical_axis) < -flick_threshold)
		or (not gp_connected and keyboard_check_pressed(up_key)))
	{
		up_flick = true;
		curr_flick = note_type.UP_NOTE;
		flick_this_frame = true;
	}
}
else if ((gp_connected and gamepad_axis_value(global.gp_index, vertical_axis) > -flick_reset_threshold)
		or (not gp_connected and keyboard_check_released(up_key)))
{
	up_flick = false;
	if (curr_flick == note_type.UP_NOTE) curr_flick = note_type.NO_NOTE;
}

// down flick
if (not down_flick)
{
	if ((gp_connected and gamepad_axis_value(global.gp_index, vertical_axis) > flick_threshold)
		or (not gp_connected and keyboard_check_pressed(down_key)))
	{
		down_flick = true;
		curr_flick = note_type.DOWN_NOTE;
		flick_this_frame = true;
	}
}
else if ((gp_connected and gamepad_axis_value(global.gp_index, vertical_axis) < flick_reset_threshold)
		or (not gp_connected and keyboard_check_released(down_key)))
{
	down_flick = false;
	if (curr_flick == note_type.DOWN_NOTE) curr_flick = note_type.NO_NOTE;
}

// left flick
if (not left_flick)
{
	if ((gp_connected and gamepad_axis_value(global.gp_index, horizontal_axis) < -flick_threshold)
		or (not gp_connected and keyboard_check_pressed(left_key)))
	{
		left_flick = true;
		curr_flick = note_type.LEFT_NOTE;
		flick_this_frame = true;
	}
}
else if ((gp_connected and gamepad_axis_value(global.gp_index, horizontal_axis) > -flick_reset_threshold)
		or (not gp_connected and keyboard_check_released(left_key)))
{
	left_flick = false;
	if (curr_flick == note_type.LEFT_NOTE) curr_flick = note_type.NO_NOTE;
}

// right flick
if (not right_flick)
{
	if ((gp_connected and gamepad_axis_value(global.gp_index, horizontal_axis) > flick_threshold)
		or (not gp_connected and keyboard_check_pressed(right_key)))
	{
		right_flick = true;
		curr_flick = note_type.RIGHT_NOTE;
		flick_this_frame = true;
	}
}
else if ((gp_connected and gamepad_axis_value(global.gp_index, horizontal_axis) < flick_reset_threshold)
		or (not gp_connected and keyboard_check_released(right_key)))
{
	right_flick = false;
	if (curr_flick == note_type.RIGHT_NOTE) curr_flick = note_type.NO_NOTE;
}

switch (curr_flick)
{
	default:
	case note_type.NO_NOTE:
		x = orig_x;
		y = orig_y;
		break;
	case note_type.UP_NOTE:
		x = orig_x;
		y = orig_y - flick_scoot;
		break;
	case note_type.DOWN_NOTE:
		x = orig_x;
		y = orig_y + flick_scoot;
		break;
	case note_type.LEFT_NOTE:
		x = orig_x - flick_scoot;
		y = orig_y;
		break;
	case note_type.RIGHT_NOTE:
		x = orig_x + flick_scoot;
		y = orig_y;
		break;
}

// chart mode
if (global.game_mode == game_modes.CHART and flick_this_frame and audio_is_playing(dj_obj.song_index))
{
	var track_pos = audio_sound_get_track_position(dj_obj.song_index) - global.offset;
	if (track_pos < 0) return;
	
	if (dj_obj.working_chart_type == chart_types.TIME)
	{
		file_text_write_real(dj_obj.working_chart, track_pos);
		file_text_write_real(dj_obj.working_chart, scr_chart_note_val(ledger_index.LEFT_STICK));
		file_text_write_real(dj_obj.working_chart, scr_chart_note_val(ledger_index.RIGHT_STICK));
		file_text_writeln(dj_obj.working_chart);
	}
	else  // beat chart
	{
		var beat = track_pos / (60 / global.bpm) + 1;
		var sixteenth = round((frac(beat) + 0.25) / 0.25);
		
		beat = floor(beat);
		if (sixteenth >= 5)
		{
			beat += 1
			sixteenth = 0;
		}
		
		file_text_write_real(dj_obj.working_chart, beat);
		file_text_write_real(dj_obj.working_chart, sixteenth);
		file_text_write_real(dj_obj.working_chart, scr_chart_note_val(ledger_index.LEFT_STICK));
		file_text_write_real(dj_obj.working_chart, scr_chart_note_val(ledger_index.RIGHT_STICK));
		file_text_writeln(dj_obj.working_chart);
	}
}
