// if song is playing, check for stop press, possibly create a new note
// otherwise check for play press
// NOTE: this limits the max rate of note creation to the step rate

// also, handle pre song
if (audio_is_playing(song_index) or pre_song_timer > 0)
{
	// track pos whether pre song or song
	if (pre_song_timer > 0)
	{
		track_pos = -pre_song_timer / game_get_speed(gamespeed_fps);
		--pre_song_timer;
		
		// play the song when pre song is over
		if (pre_song_timer <= 0)
		{
			song_index = audio_play_sound(song, 1, false);
		}
	}
	else
	{
		track_pos = audio_sound_get_track_position(song_index);
	}
	
	if (gamepad_button_check_pressed(0, gp_select) or keyboard_check_pressed(vk_backspace))
	{
		audio_stop_all();
		pre_song_timer = 0;
		playhead = 0;
	}
	
	if (playhead < note_count)
	{
		var note_time = ds_grid_get(ledger, playhead, ledger_index.NOTE_TIME);
		if (track_pos + read_ahead_time >= note_time)
		{
			scr_create_note(ledger, playhead, ledger_index.LEFT_STICK, note_speed, note_time);
			scr_create_note(ledger, playhead, ledger_index.RIGHT_STICK, note_speed, note_time);
			++playhead;
		}
	}
}
else if (gamepad_button_check_pressed(0, gp_start) or keyboard_check_pressed(vk_enter))
{
	pre_song_timer = pre_song_time * game_get_speed(gamespeed_fps);
	if (pre_song_timer = 0) pre_song_timer = 1;
}

// close on escape key
if (keyboard_check_pressed(vk_escape))
{
	if (global.game_mode == game_modes.CHART) file_text_close(working_chart);
	game_end();
}