// close on escape key
if (keyboard_check_pressed(vk_escape))
{
	game_end();
}

// if song is playing, check for stop press, possibly create a new note
// otherwise check for play press
// NOTE: this limits the max rate of note creation to the step rate

// also, handle pre song
// a positive pre_song_timer indicates that the song is "playing" but in pre song
if (audio_is_playing(song_index) or pre_song_timer > 0)
{
	// check for stop
	if (gamepad_button_check_pressed(global.gp_index, gp_select))
	{
		audio_stop_all();
		pre_song_timer = 0;
		playhead = 0;
		
		// clear hold notes
		var stick = left_stick_obj;
		repeat (2)
		{
			if (stick.last_hold != noone) stick.last_hold.hold_start = false;
			stick.last_hold = noone;
			stick.curr_hold = noone;
			stick = right_stick_obj;
		}
	}
	else
	{
		// track pos whether pre song or song
		if (pre_song_timer > 0)
		{
			pre_song_timer -= 1 / game_get_speed(gamespeed_fps);
		
			// play the song when pre song is over
			if (pre_song_timer <= 0)
			{
				song_index = audio_play_sound(song, 1, false);
				track_pos = 0;
			}
			else
			{
				track_pos = -pre_song_timer;
			}
		}
		else
		{
			track_pos = audio_sound_get_track_position(song_index);
		}
	
		// if notes available
		if (playhead < note_count)
		{
			var note_time = ds_grid_get(ledger, playhead, ledger_index.NOTE_TIME);
			while (track_pos + read_ahead_time >= note_time)
			{
				scr_create_note(ledger, playhead, note_time);
				++playhead;
				if (playhead >= note_count) break;
				note_time = ds_grid_get(ledger, playhead, ledger_index.NOTE_TIME);
			}
		}
	}
}
else if (gamepad_button_check_pressed(global.gp_index, gp_start))
{
	// either start pre song or play song
	pre_song_timer = pre_song_time;
	if (pre_song_timer == 0) song_index = audio_play_sound(song, 1, false);
}