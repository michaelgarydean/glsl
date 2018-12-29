// Example Vertex Shader

uniform int numVertices;

/*
0: -1,0
1: 0.0, 1
2: 1,0
3: -1,0
*/

void main() 
{
	int vertex_i = gl_VertexID;

	//repeat the first vertex position to close the shape
	if(vertex_i == numVertices-1) {
		vertex_i = 0;
	}

	//displace vertices
	vec3 pos = vec3(vec2(vertex_i-1.0,vertex_i%2)/numVertices,0.0);

	//translate to space
	vec4 worldSpacePos = TDDeform(pos);
	gl_Position = TDWorldToProj(worldSpacePos);
}


