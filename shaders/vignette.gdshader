shader_type canvas_item;

uniform float radius;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	uv -= 0.5;
	uv /= radius;
	float alpha = length(uv);
	COLOR.rgb = vec3(0.0);
	COLOR.a = alpha;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
