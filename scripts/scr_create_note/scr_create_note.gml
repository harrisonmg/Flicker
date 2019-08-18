/// @desc Read a note at a playhead position on a ledger and create it.
/// @arg ledger
/// @arg playhead
/// @arg note_time

var ledger		= argument0;
var playhead	= argument1;

var new_note_time	= argument2;
var new_note_stick	= ds_grid_get(ledger, playhead, ledger_index.STICK);
var new_note_type	= ds_grid_get(ledger, playhead, ledger_index.NOTE_TYPE);
var new_note_dir	= ds_grid_get(ledger, playhead, ledger_index.NOTE_DIR);
var new_note_layer, new_note_ang;

switch (new_note_stick)
{
	case sticks.LEFT:
	{
		new_note_stick = left_stick_obj;
		break;
	}

	case sticks.RIGHT:
	{
		new_note_stick = right_stick_obj;
		break;
	}
	
	default:
	{
		// TODO: error
		break;
	}
}

switch(new_note_type)
{
	case note_types.HOLD:
	{
		if (new_note_stick.last_hold != noone)
		{
			// draw hold ends on higher layer so hold lines are drawn under
			new_note_layer = "HoldEnds";
		}
		else
		{
			new_note_layer = "Notes";
		}
		break;
	}
	
	case note_types.SINGLE:
	{
		new_note_layer = "Notes";
		break;
	}
	
	default:
	{
		// TODO: error
		break;
	}
}

switch (new_note_dir)
{
	case note_dirs.UP:
	{
		new_note_ang = 90;
		break;
	}
	case note_dirs.DOWN:
	{
		new_note_ang = 270;
		break;
	}
	case note_dirs.LEFT:
	{
		new_note_ang = 180;
		break;
	}
	case note_dirs.RIGHT:
	{
		new_note_ang = 0;
		break;
	}
	
	default:
	{
		// TODO: error
		break;
	}
}

new_note = instance_create_layer(new_note_stick.orig_x, -5, new_note_layer, obj_note);	

new_note.speed			= note_speed;
new_note.direction		= 270;  // down
new_note.image_angle	= new_note_ang;

new_note.note_time	= new_note_time;
new_note.note_stick	= new_note_stick;
new_note.note_type	= new_note_type;
new_note.note_dir	= new_note_dir;

if (new_note_type == note_types.HOLD)
{
	if (new_note_stick.last_hold == noone)
	{
		new_note.hold_start = true;
		new_note_stick.last_hold = new_note;
	}
	else
	{
		new_note.hold_start = false;
		new_note_stick.last_hold.hold_end = new_note;
		new_note_stick.last_hold = noone;
	}
}