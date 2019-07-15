/// @desc Read a note at a playhead position on a ledger and create it.
/// @arg ledger
/// @arg playhead
/// @arg stick_index
/// @arg note_speed
/// @arg note_time

var ledger = argument0;
var playhead = argument1;
var stick_index = argument2;
var note_speed = argument3;
var note_time = argument4;

var new_note, note_obj, note_ang;
var type_of_note = ds_grid_get(ledger, playhead, stick_index);
switch (type_of_note)
{
	case note_type.UP_NOTE:
	{
		note_obj = obj_note;
		note_ang = 90;
		break;
	}
	case note_type.DOWN_NOTE:
	{
		note_obj = obj_note;
		note_ang = 270;
		break;
	}
	case note_type.LEFT_NOTE:
	{
		note_obj = obj_note;
		note_ang = 180;
		break;
	}
	case note_type.RIGHT_NOTE:
	{
		note_obj = obj_note;
		note_ang = 0;
		break;
	}
	case note_type.NO_NOTE:
	default:
		return;
}

if (stick_index == ledger_index.LEFT_STICK)
{
	new_note = instance_create_layer(
		left_stick_obj.orig_x, -5, "Notes", note_obj);	
	new_note.note_stick = left_stick_obj;
}
else
{
	new_note = instance_create_layer(
		right_stick_obj.orig_x, -5, "Notes", note_obj);	
	new_note.note_stick = right_stick_obj;
}

new_note.direction = 270;
new_note.image_angle = note_ang;
new_note.speed = note_speed;
new_note.note_time = note_time;
new_note.note_dir = type_of_note;