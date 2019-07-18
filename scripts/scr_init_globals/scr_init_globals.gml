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
	NO_NOTE    = 0,
	UP_NOTE    = 1,
	DOWN_NOTE  = 2,
	LEFT_NOTE  = 3,
	RIGHT_NOTE = 4
}

enum game_modes
{
	PLAY,
	CHART
}

global.game_mode = game_modes.CHART;

global.gp_index = 0;