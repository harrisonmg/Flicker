image_alpha -= fade_out_alpha_delta;

if (image_alpha <= 0)
{
	instance_destroy();
}