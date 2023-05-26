/* 
Basic shape glow post-processing effect.
Required to be put on a quad mesh that is rendered in the scene.
Required associated script to control the transform of the shape.
Parts of the code are created by Inigo Quilez and used under the MIT license:
https://iquilezles.org/articles/
Godot 4 adaptation by Christopher Marín

Copyright 2023 Michael Watt, Inigo Quilez and Christopher Marín 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files 
(the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to 
do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE 
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Video tutorial on YouTube: https://youtu.be/0BXBXy8zaaI
*/

shader_type spatial;
render_mode unshaded;

// Settings to play with
uniform float pulse_width = 1.0;
uniform vec4 color : source_color;
uniform vec3 box_dimensions = vec3(1.0);
uniform float roundness = 1.0;

// Updated by Script
uniform mat4 shape_transform = mat4(1.0);
uniform float size = 1.0;

// Godot 4 screen texture and depth texture
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D DEPTH_TEXTURE : hint_depth_texture, filter_linear_mipmap;

// Not sure this is actually needed, but used in Documentation.
varying mat4 CAMERA;

// Signed Distance Function by Inigo Quilez
float sdRoundBox( vec3 p, vec3 b, float r )
{
  vec3 q = abs(p) - b;
  return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0) - r;
}

void vertex() {
	// Set the Quad to cover the entire screen.
	// If it doesn't, resize the quad (x,y) to (2,2)
	POSITION = vec4(VERTEX, 1.0);
	
	// Again, from the docs, we need the interpolated camera matrix
	// Which I think you can just get in the fragment shader?
	CAMERA = INV_VIEW_MATRIX;
}


void fragment() {
	// Get the original screen rendered texture at the screen uv coordinates.
	vec4 original = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	// Get the depth value form the depth buffer. Stored in the x value
	// of the depth texture.
	float depth = texture(DEPTH_TEXTURE, SCREEN_UV).x;
	
	// Normalized Device Coordinates (clip space... mostly)
	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);
	
	// Convert to world space from NDC
	vec4 world = CAMERA * INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	vec3 world_position = world.xyz / world.w;
	
	// Transform the world_position of the fragment based on the shape's transform.
	// In the case of SDFs, the inverse of the shape's transform is required.
	vec3 adjusted_position = (inverse(shape_transform) * vec4(world_position, 1.0)).xyz;
	
	// Use the Signed Distance Function to calculate how far away the position is from the
	// desired shape.
	float dist = sdRoundBox(adjusted_position, box_dimensions * size, roundness * size);

	float mix_ratio = 0.0;
	
	if (dist <= 0.0 && dist > -pulse_width){
		float percentage = abs(dist) / abs(pulse_width);
		mix_ratio = 1.0 - percentage;
		
		// Clamp the mix ratio to avoid any unexpected visual bugs.
		mix_ratio = clamp(mix_ratio, 0.0, 1.0);
	}
	
	ALBEDO = mix(original.rgb, color.rgb, mix_ratio);
}