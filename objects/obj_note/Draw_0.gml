if (note_type == note_types.HOLD)
{
		
	// the starting hold note 
	if (hold_start)
	{
		// starting hold note draws hold line
		if (hold_end == noone)
		{
			draw_line_width_color(x-1, y, x-1, 0, hold_line_width, c_hold_line, c_hold_line);
		}
		else
		{
			draw_line_width_color(x-1, y, hold_end.x-1, hold_end.y, hold_line_width, c_hold_line, c_hold_line);
		}
		
		// hold notes have a marker
		draw_sprite(spr_hold, 0, x, y);
	}
	else
	{
		// hold notes have a marker
		draw_sprite_ext(spr_hold, 0, x, y, 1, 1, 180, c_white, 1);
	}
}

// do last to be over hold stuff if present
draw_self();