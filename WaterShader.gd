shader_type spatial;

uniform float wave_height : hint_range(0.0, 1.0) = 0.1;
uniform float wave_speed : hint_range(0.0, 2.0) = 0.5;
uniform vec4 water_color : hint_color = vec4(0.0, 0.5, 1.0, 0.8);
uniform sampler2D noise_texture : hint_white;

void vertex() {
    vec4 noise = texture(noise_texture, VERTEX.xz * 0.1 + TIME * wave_speed * 0.1);
    VERTEX.y += sin(VERTEX.x * 10.0 + TIME * wave_speed) * wave_height * noise.r;
}

void fragment() {
    ALBEDO = water_color.rgb;
    METALLIC = 0.5;
    ROUGHNESS = 0.2;
    ALPHA = water_color.a;
}
