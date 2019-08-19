/// @desc Check for a flick and respond with the appropriate actions.

flick_this_frame = false;

var vert = gamepad_axis_value(global.gp_index, vertical_axis);
var hori = gamepad_axis_value(global.gp_index, horizontal_axis);

// up flick
if (curr_flick != note_dirs.UP)
{
	if (vert < -flick_threshold)
	{
		curr_flick = note_dirs.UP;
		flick_this_frame = true;
	}
}

// down flick
if (curr_flick != note_dirs.DOWN)
{
	if (vert > flick_threshold)
	{
		curr_flick = note_dirs.DOWN;
		flick_this_frame = true;
	}
}

// left flick
if (curr_flick != note_dirs.LEFT)
{
	if (hori < -flick_threshold)
	{
		curr_flick = note_dirs.LEFT;
		flick_this_frame = true;
	}
}

// right flick
if (curr_flick != note_dirs.RIGHT)
{
	if (hori > flick_threshold)
	{
		curr_flick = note_dirs.RIGHT;
		flick_this_frame = true;
	}
}

if (not flick_this_frame)
{
	if (abs(vert) <= flick_reset_threshold and abs(hori) <= flick_reset_threshold)
	{
		curr_flick = -1;
		
		// handle hold notes
		if (curr_hold != noone)
		{
			curr_hold.active = false;
			curr_hold.sprite_index = spr_missed_note;
			curr_hold = noone;
			obj_dj.streak = 0;
		}
	}
}


// animation
switch (curr_flick)
{
	case note_dirs.UP:
	{
		x = orig_x;
		y = orig_y - flick_scoot;
		break;
	}
	
	case note_dirs.DOWN:
	{
		x = orig_x;
		y = orig_y + flick_scoot;
		break;
	}

	case note_dirs.LEFT:
	{
		x = orig_x - flick_scoot;
		y = orig_y;
		break;
	}
		
	case note_dirs.RIGHT:
	{
		x = orig_x + flick_scoot;
		y = orig_y;
		break;
	}
	
	default:
	{
		x = orig_x;
		y = orig_y;
		break;
	}
}
