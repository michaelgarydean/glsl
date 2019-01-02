/*
 Sample RGB values as XYZ positions from a TOP and displace vertices.
*/

//A 2D matrix to sample from
uniform sampler2D sPointPosition;

//the number of points in the geometery
uniform float uPointsPerInstance;

//vertex index as input
in float pointIndex;

void main()
{
    gl_PointSize = 4.0;  	// set point size to your liking

    // create the uv from point index
    vec2 uv;

    //sample the value from the middle of a pixel (add 0.5). Edges cause error on leftmost pixel.
    uv.x = (pointIndex * uPointsPerInstance) + (uPointsPerInstance * 0.5);
    uv.y = 0.5;

    // sample the noise texture using the uv
    vec4 newPosition = texture(sPointPosition, uv);

    // move point from object space to screen space and output to gl_Position
    vec4 worldSpaceVert = TDDeform(newPosition);
    gl_Position = TDWorldToProj(worldSpaceVert);
}