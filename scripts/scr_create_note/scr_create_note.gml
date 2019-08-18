/// @desc Read a note at a playhead position on a ledger and create it.
/// @arg ledger
/// @arg playhead
/// @arg note_speed
/// @arg note_time

var ledger		= argument0;
var playhead	= argument1;
var note_speed	= argument2;

var new_note_time	= argument3;
var new_note_stick	= ds_grid_get(ledger, playhead, ledger_index.STICK);
var new_note_type	= ds_grid_get(ledger, playhead, ledger_index.NOTE_TYPE);
var new_note_dir	= ds_grid_get(ledger, playhead, ledger_index.NOTE_DIR);
var new_note_ang;

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

new_note = instance_create_layer(new_note_stick.orig_x, -5, "Notes", obj_note);	

new_note.speed			= note_speed;
new_note.direction		= 270;  // down
new_note.image_angle	= new_note_ang;

new_note.note_time	= new_note_time;
new_note.note_stick	= new_note_stick;
new_note.note_type	= new_note_type;
new_note.note_dir	= new_note_dir;