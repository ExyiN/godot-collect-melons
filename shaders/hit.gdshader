shader_type canvas_item;

uniform vec4 color: source_color = vec4(1.0f);
uniform bool show = false;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	if (show) {		
		COLOR = color;
		COLOR.a = original_color.a;
	}
}
