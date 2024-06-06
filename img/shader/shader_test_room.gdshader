shader_type canvas_item;
uniform vec2 fragments= vec2(5,5);
uniform float progress : hint_range(0.0, 1.0)=0;
void fragment() {
	vec2 pixel_fract =fract(UV*fragments);
	//COLOR.rgb = vec3(pixel_fract,0);
	float pixel_distance = distance(pixel_fract,vec2(0.5,0.5));
	//COLOR.rgb=vec3(pixel_distance,0,0);
	COLOR=texture(TEXTURE,UV);
	COLOR.a*=step(pixel_distance,progress);
	
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
