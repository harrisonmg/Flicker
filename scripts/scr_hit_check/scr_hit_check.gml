/// @desc Check for a hit and respond with the appropriate actions.

if (active)
{
	switch (note_type)
	{
		case note_types.HOLD:
		{
			if (hold_start)
			{
				// treat mostly as regular single note
				// past start of hit window?
				if (dj_obj.track_pos >= note_time - time_padding)
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
							note_stick.image_index = 0;
							note_stick.curr_hold = self;
							//audio_play_sound(snd_hit, 1, false);
							++dj_obj.streak;
						}
					}
					else
					{
						// past hit window, miss
						active = false;
						sprite_index = spr_missed_note;
						note_stick.curr_hold = noone;
						//audio_play_sound(snd_miss, 1, false);
						dj_obj.streak = 0;
					}
				}
			}
			else
			{
				// past start of relelase (same as hit) window?
				if (dj_obj.track_pos >= note_time - time_padding)
				{
					// still inside hit window?
					if (dj_obj.track_pos <= note_time + time_padding)
					{		
						// if correct direction is being held at any point during this window
						// give em the hit and release the stick of the duty
						// hold failure is handled prior in the flick check
						// but direction is handled here
						if (note_stick.curr_flick == note_dir)
						{
							active = false;
							note_stick.curr_hold = noone
							sprite_index = spr_hit_note;
							note_stick.sprite_index = spr_glow_stick;
							note_stick.image_index = 0;
							//audio_play_sound(snd_hit, 1, false);  // will be at beginning of window, out of sync with music
							++dj_obj.streak;
						}
					}
					else
					{
						// past hit window, didn't make it
						active = false;
						sprite_index = spr_missed_note;
						other_hold.sprite_index = spr_missed_note;
						note_stick.curr_hold = noone;
						//audio_play_sound(snd_miss, 1, false);
						dj_obj.streak = 0;
					}
				}
			}
			break;
		}
		
		case note_types.SINGLE:
		default:
		{
			// past start of hit window?
			if (dj_obj.track_pos >= note_time - time_padding)
			{
				// still inside hit window?
				if (dj_obj.track_pos <= note_time + time_padding)
				{		
					// check for hit (can also hit by being in the right direction during a hold)
					if ((note_stick.flick_this_frame or note_stick.curr_hold != noone)
						and note_stick.curr_flick == note_dir)
					{
						active = false;
						sprite_index = spr_hit_note;
						note_stick.sprite_index = spr_glow_stick;
						note_stick.image_index = 0;
						//audio_play_sound(snd_hit, 1, false);
						++dj_obj.streak;
					}
				}
				else
				{
					// past hit window, miss
					active = false;
					sprite_index = spr_missed_note;
					//audio_play_sound(snd_miss, 1, false);
					dj_obj.streak = 0;
				}
			}
			break;
		}
	}
}