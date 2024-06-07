shader_type canvas_item;
uniform float explosion_speed : hint_range(0.1, 10.0) = 1.0;
uniform float explosion_radius : hint_range(0.1, 5.0) = 1.0;

void fragment() {
	vec2 center = vec2(0.5, 0.5);
	vec2 distance = center - FRAGCOORD.xy / vec2(1.0 / TEXTURE_PIXEL_SIZE.x, 1.0 / TEXTURE_PIXEL_SIZE.y);
	float distance_from_center = length(distance);
	float scale = 1.0 + explosion_speed * distance_from_center;
	float transparency = 1.0 - clamp(explosion_speed * distance_from_center, 0.0, 1.0);
	COLOR.a *= transparency;
	vec2 uv = FRAGCOORD.xy * TEXTURE_PIXEL_SIZE;
	vec2 centeredUV = uv - center;
	vec2 offset = centeredUV * scale - centeredUV;
	vec2 newUV = uv + offset * explosion_radius;
	vec4 textureColor = texture(TEXTURE, newUV);
	COLOR *= textureColor;
}