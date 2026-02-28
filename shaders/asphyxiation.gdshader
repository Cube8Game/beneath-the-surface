shader_type canvas_item;

uniform float oxygen;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	uv -= 0.5;
	uv *= 5.0;

	float dist = length(uv);      // Distance from center
	float angle = atan(uv.y, uv.x);   // Angle in radians (-PI to PI)

	COLOR.a = sin(TAU * 10.0 * (angle + PI) / (2.0 * PI)) * oxygen * dist;
	COLOR.gb = vec2(0.0);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
