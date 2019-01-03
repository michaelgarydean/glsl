uniform vec4 uDiffuseColor;
uniform vec4 uAmbientColor;
uniform vec3 uSpecularColor;
uniform float uShininess;
uniform vec3 uEmission;
uniform float uShadowStrength;
uniform vec3 uShadowColor;

uniform sampler2D disp;
uniform float dispScale;

out Vertex {
	vec4 color;
	vec3 worldSpacePos;
	vec3 worldSpaceNorm;
	flat int cameraIndex;
}vVert;

void main()
{

	//sample r in texture from current point coordinates and scale it
	float dispZ 		= texture( disp, uv[0].st ).r * dispScale;

	//displace the z coordinates
	vec3 newP 			= vec3( P.x, P.y, P.z + dispZ );

	// First deform the vertex and normal
	// TDDeform always returns values in world space
	vec4 worldSpacePos =TDDeform( newP );
	gl_Position = TDWorldToProj(worldSpacePos);

	// This is here to ensure we only execute lighting etc. code
	// when we need it. If picking is active we don't need this, so
	// this entire block of code will be ommited from the compile.
	// The TD_PICKING_ACTIVE define will be set automatically when
	// picking is active.
#ifndef TD_PICKING_ACTIVE

	vVert.cameraIndex = TDCameraIndex();
	vVert.worldSpacePos.xyz = worldSpacePos.xyz;
	vVert.color = TDInstanceColor(Cd);
	vec3 worldSpaceNorm = TDDeformNorm(N);
	vVert.worldSpaceNorm = normalize(worldSpaceNorm);

#else // TD_PICKING_ACTIVE

	// This will automatically write out the nessessary values
	// for this shader to work with picking.
	// See the documentation if you want to write custom values for picking.
	TDWritePickingValues();

#endif // TD_PICKING_ACTIVE
}
