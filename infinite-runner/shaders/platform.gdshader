shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform vec2 scale;
uniform float y_zoom;

void fragment() {
	float uv_height = SCREEN_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.y;
	vec2 reflected_screenuv = vec2(SCREEN_UV.x, SCREEN_UV.y + uv_height * UV.y * scale.y * y_zoom * -2.0);
	
	COLOR = texture(SCREEN_TEXTURE, reflected_screenuv);
	COLOR.a = 0.15;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
