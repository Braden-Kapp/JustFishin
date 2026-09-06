shader_type canvas_item;

uniform sampler2D water : hint_default_white;
uniform sampler2D noise : repeat_enable;
uniform vec2 scrollSpeed = vec2(0.03, 0.02);
uniform float distortion_strength : hint_range(0.0, 0.1) = 0.02;

void fragment() {
    // Calculate moving UV coordinates
    vec2 noise_uv = UV + (TIME * scrollSpeed);
    
    // Sample noise
    float noise_value = texture(noise, noise_uv).r;
    
    // use noise to offset UV
    vec2 distorted_uv = UV + vec2(noise_value * distortion_strength);
    
    //PNG with distorted UV
    COLOR = texture(water, distorted_uv);
}