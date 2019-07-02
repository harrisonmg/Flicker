var track_pos = audio_sound_get_track_position(dj_obj.song);

// active and past start of hit window?
if (active and track_pos >= note_time - time_padding)
{
	// still inside hit window?
	if (track_pos <= note_time + time_padding)
	{
		if (note_stick == ledger_index.LEFT_STICK)
		{
			// check for hit
			if (left_stick_obj.flick_this_frame
				and left_stick_obj.curr_flick == note_dir)
			{
				active = false;
				sprite_index = hit_note;
				audio_play_sound(hit, 1, false);
			}
		}
		else
		{
			// check for hit
			if (right_stick_obj.flick_this_frame
				and right_stick_obj.curr_flick == note_dir)
			{
				active = false;
				sprite_index = hit_note;
				audio_play_sound(hit, 1, false);
			}
		}
	}
	else
	{
		// past hit window, miss
		active = false;
		sprite_index = missed_note;
		audio_play_sound(miss, 1, false);
	}
}