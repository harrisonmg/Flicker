// active and past start of hit window?
if (active and dj_obj.track_pos >= note_time - time_padding)
{
	// still inside hit window?
	if (dj_obj.track_pos <= note_time + time_padding)
	{		
		// check for hit
		if (note_stick.flick_this_frame
			and note_stick.curr_flick == note_dir)
		{
			active = false;
			sprite_index = spr_hit_note;
			note_stick.sprite_index = spr_glow_stick;
			audio_play_sound(snd_hit, 1, false);
			++dj_obj.streak;
		}
	}
	else
	{
		// past hit window, miss
		active = false;
		sprite_index = spr_missed_note;
		audio_play_sound(snd_miss, 1, false);
		dj_obj.streak = 0;
	}
}