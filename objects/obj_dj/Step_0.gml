if (audio_is_playing(song))
{
	if (gamepad_button_check_pressed(0, gp_select) or keyboard_check_pressed(vk_backspace))
	{
		audio_stop_all();
		playhead = 0;
	}
	
	if (playhead < note_count)
	{
		var note_time = ds_grid_get(ledger, playhead, ledger_index.NOTE_TIME);
		if (audio_sound_get_track_position(song) + read_ahead_time >= note_time)
		{
			scr_create_note(ledger, playhead, ledger_index.LEFT_STICK, note_speed, note_time);
			scr_create_note(ledger, playhead, ledger_index.RIGHT_STICK, note_speed, note_time);
			++playhead;
		}
	}
}
else if (gamepad_button_check_pressed(0, gp_start) or keyboard_check_pressed(vk_enter))
{
	song = audio_play_sound(flicker, 1, false);
}

if (keyboard_check_pressed(vk_escape))
{
	game_end();
}