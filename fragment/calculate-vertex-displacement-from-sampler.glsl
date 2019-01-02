out vec4 fragColor;

void main()
{

// sample the inputs
vec4 objPosition = texture(sTD2DInputs[0], vUV.st);		//the original object coordinates
vec4 modPosition = texture(sTD2DInputs[1], vUV.st);		//coordinates to displace the object's coordinates

//scale the displacement amount
float scale = 0.24;

//calculate the new coordinates with the displacement
vec4 outPosition = vec4(objPosition.x + (modPosition.x*scale), objPosition.y + (modPosition.y*scale), objPosition.z + (modPosition.z), 1.0);

//or, output coordinates with no change
//vec4 outPosition = vec4(objPosition.x, objPosition.y, objPosition.z, 1.0);

// output the new position
fragColor = outPosition;
}