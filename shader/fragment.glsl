#version 120                  // GLSL 1.20

uniform mat4 u_model_matrix;
uniform mat3 u_normal_matrix;

uniform vec3 u_light_position;
uniform vec3 u_light_ambient;
uniform vec3 u_light_diffuse;
uniform vec3 u_light_specular;

uniform vec3  u_obj_ambient;
uniform vec3  u_obj_diffuse;
uniform vec3  u_obj_specular;
uniform float u_obj_shininess;

uniform vec3 u_camera_position;
uniform mat4 u_view_matrix;

uniform sampler2D u_diffuse_texture;

varying   vec2 v_texcoord; 
//varying vec3 v_color;
varying vec3 position;
varying vec3 normal; 

vec3 directional_light() 
{
  vec3 color = vec3(0.0);

  vec3 position_wc = (u_model_matrix * vec4(position, 1.0f)).xyz;
  vec3 normal_wc   = normalize(u_normal_matrix * normal);

  vec3 light_dir = normalize(u_light_position);

  // ambient
  color += (u_light_ambient * u_obj_ambient);
  
  // diffuse 
  float ndotl = max(dot(normal_wc, light_dir), 0.0);
  color += (ndotl * u_light_diffuse * u_obj_diffuse);

  // specular
  vec3 view_dir = normalize(u_camera_position - position_wc);
  vec3 reflect_dir = reflect(-light_dir, normal_wc); 

  float rdotv = max(dot(view_dir, reflect_dir), 0.0);
  color += (pow(rdotv, u_obj_shininess) * u_light_specular * u_obj_specular);

  return color;
}


void main()
{
	vec4 base_color = texture2D(u_diffuse_texture, v_texcoord);
	gl_FragColor = base_color*vec4(directional_light(), 1.0f);

	// gl_FragColor = vec4(v_color, 1.0f);
}