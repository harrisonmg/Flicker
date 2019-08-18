/// @desc Define globals for use in the game.

enum chart_types
{
	TIME	= 0,
	BEAT	= 1
}

enum ledger_index
{
	NOTE_TIME		= 0,
	STICK			= 1,
	NOTE_TYPE		= 2,
	NOTE_DIR		= 3,
	LEDGER_HEIGHT
}

enum sticks
{
	LEFT	= 0,
	RIGHT	= 1
}

enum note_types
{
	SINGLE	= 0,
	HOLD	= 1
}

enum note_dirs
{
	UP		= 0,
	DOWN	= 1,
	LEFT	= 2,
	RIGHT	= 3,
}

global.gp_index = 0;