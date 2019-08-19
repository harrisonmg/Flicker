// check for offscreen to destroy
if (y - (sprite_height / 2) > room_height)
{
	if (note_type == note_types.HOLD)
	{
		// only hold ends can destory each end of the hold
		if (not hold_start)
		{
			instance_destroy(other_hold);
			instance_destroy();
		}
	}
	else
	{
		instance_destroy();
	}
}

scr_hit_check();