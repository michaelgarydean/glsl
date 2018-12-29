/* 
@author Michael Dean

First shader attempt. Inspired by Lissajous figures, as found in 'Generative design'
*/

uniform float uTime;
uniform int selector;


void main() 
{
	vec3 pos;

	//Switch statement is only used because the condition is from a uniform
	switch(selector) {
			case 0 : {
				pos = vec3(sin(gl_VertexID*uTime*0.1),cos(gl_VertexID*uTime*0.2),cos(gl_VertexID*uTime*0.1));
				break;
			} 
			case 1 : {
				pos = vec3(sin(gl_VertexID*uTime*0.000001),cos(gl_VertexID*uTime*0.0000001),tan(gl_VertexID*uTime*0.0000002));
				break;
			}
			case 2 : {
				pos = vec3(sin(gl_VertexID*uTime*0.000001),cos(gl_VertexID*uTime*0.000001),tan(gl_VertexID*uTime*0.00000002));
			break;
			}
	} 
	vec4 worldSpacePos = TDDeform(pos);
	gl_Position = TDWorldToProj(worldSpacePos);
}


