/// @desc Remove comments from a chart and return the cleaned file handle, preserving the original.
/// @arg chart file handle

var orig_chart = argument0;
var clean_chart_str = "";

while (!file_text_eof(orig_chart))
{
	var line = file_text_readln(orig_chart);
	var last_char = 0;
	
	for (var i = 0; i < string_length(line); ++i)
	{
		var curr_byte = string_byte_at(line, i);
		if (curr_byte == ord("#"))
		{
			line = string_copy(line, 0, last_char) + "\n";
		}
		else if (string_lettersdigits(chr(curr_byte)) != "")
		{
			last_char = i;
		}
	}
	
	// skip lines with nothing good on them
	if (string_lettersdigits(line) == "") continue;
	clean_chart_str += line;
}

show_debug_message(clean_chart_str);
return file_text_open_from_string(clean_chart_str);