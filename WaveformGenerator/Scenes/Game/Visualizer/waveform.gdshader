shader_type canvas_item;

uniform float fade_start : hint_range(0.0, 1.0) = 0.0;
uniform float fade_end   : hint_range(0.0, 1.0) = 1.0;
uniform vec4 line_color : source_color = vec4(1.0);

void fragment() {
    // DO NOT use COLOR — it's usually 0 in Line2D shaders
    vec4 col = line_color;

    float u = UV.x; // will only work if a texture is set OR fill mode = stretch

    float fade = smoothstep(fade_start, fade_end, u);
    COLOR = vec4(col.rgb, col.a * fade);
}