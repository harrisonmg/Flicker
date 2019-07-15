/// @desc Define globals for use in the game.

enum chart_types
{
	TIME = 0,
	BEAT = 1
}

enum ledger_index
{
	NOTE_TIME,
	LEFT_STICK,
	RIGHT_STICK
}

enum note_type
{
	NO_NOTE,
	UP_NOTE,
	DOWN_NOTE,
	LEFT_NOTE,
	RIGHT_NOTE
}

enum game_modes
{
	PLAY,
	CHART
}

global.game_mode = game_modes.CHART;