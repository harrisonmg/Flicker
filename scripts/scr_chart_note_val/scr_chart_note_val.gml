/// @desc Get the stick note value for writing to a chart.
/// @arg stick_index

var stick_index = argument0;

if (stick_index == ledger_index.LEFT_STICK and vertical_axis == gp_axislv)
	or (stick_index == ledger_index.RIGHT_STICK and vertical_axis == gp_axisrv)
{
	return curr_flick;
}
else
{
	return 0;
}