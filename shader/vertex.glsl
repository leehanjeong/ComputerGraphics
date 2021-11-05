#version 120                  // GLSL 1.20

uniform mat4 u_PVM;

attribute vec3 a_position;    // per-vertex position (per-vertex input)
attribute vec3 a_normal;
attribute vec2 a_texcoord;

varying vec2 v_texcoord;
varying vec3 position;
varying vec3 normal; 

void main()
{
  position = a_position;
  normal = a_normal;
  gl_Position = u_PVM * vec4(position, 1.0f);
  v_texcoord = a_texcoord;
}