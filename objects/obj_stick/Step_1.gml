flick_this_frame = false;

// up flick
if (not up_flick)
{
	if ((gamepad_axis_value(0, vertical_axis) < -flick_threshold)
		or keyboard_check_pressed(up_key))
	{
		up_flick = true;
		curr_flick = note_type.UP_NOTE;
		scr_on_flick();
	}
}
else if (gamepad_axis_value(0, vertical_axis) > -flick_reset_threshold)
{
	up_flick = false;
	if (curr_flick == note_type.UP_NOTE) curr_flick = note_type.NO_NOTE;
}

// down flick
if (not down_flick)
{
	if ((gamepad_axis_value(0, vertical_axis) > flick_threshold)
		or keyboard_check_pressed(down_key))
	{
		down_flick = true;
		curr_flick = note_type.DOWN_NOTE;
		scr_on_flick();
	}
}
else if (gamepad_axis_value(0, vertical_axis) < flick_reset_threshold)
{
	down_flick = false;
	if (curr_flick == note_type.DOWN_NOTE) curr_flick = note_type.NO_NOTE;
}

// left flick
if (not left_flick)
{
	if ((gamepad_axis_value(0, horizontal_axis) < -flick_threshold)
		or keyboard_check_pressed(left_key))
	{
		left_flick = true;
		curr_flick = note_type.LEFT_NOTE;
		scr_on_flick();
	}
}
else if (gamepad_axis_value(0, horizontal_axis) > -flick_reset_threshold)
{
	left_flick = false;
	if (curr_flick == note_type.LEFT_NOTE) curr_flick = note_type.NO_NOTE;
}

// right flick
if (not right_flick)
{
	if ((gamepad_axis_value(0, horizontal_axis) > flick_threshold)
		or keyboard_check_pressed(right_key))
	{
		right_flick = true;
		curr_flick = note_type.RIGHT_NOTE;
		scr_on_flick();
	}
}
else if (gamepad_axis_value(0, horizontal_axis) < flick_reset_threshold)
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