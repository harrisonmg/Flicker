if (note_type == note_types.HOLD)
{
	switch (sprite_index)
	{
		default:
		case spr_note:
			var c_hold_line = c_hold_line_active;
			break;
			
		case spr_hit_note:
			var c_hold_line = c_hold_line_hit;
			break;
			
		case spr_missed_note:
			var c_hold_line = c_hold_line_miss;
			break;
	}
	
	// the starting hold note 
	if (hold_start)
	{
		// starting hold note draws hold line
		if (other_hold == noone)
		{
			draw_line_width_color(x-1, y, x-1, 0, hold_line_width, c_hold_line, c_hold_line);
		}
		else
		{
			draw_line_width_color(x-1, y, other_hold.x-1, other_hold.y, hold_line_width, c_hold_line, c_hold_line);
		}
		
		// hold notes have a marker
		draw_sprite(spr_hold, 0, x, y);
	}
	else
	{
		// share index of other note if missed
		// also fuck it just deactivate
		if (active and other_hold != noone and other_hold.sprite_index == spr_missed_note)
		{
			active = false;
			sprite_index = spr_missed_note;
		}
		
		// hold notes have a marker
		draw_sprite_ext(spr_hold, 0, x, y, 1, 1, 180, c_white, 1);
	}
}

// do last to be over hold stuff if present
draw_self();