#version 300 es

// Create shared variable for the vertex and fragment shaders
out vec3 interpolatedNormal;
out float intensity;

uniform vec3 bunnyPosition;
uniform vec3 lightPosition;
uniform vec3 armadilloPosition;


void main() {
    // Calculate position in world coordinates
    vec4 wpos = modelMatrix * vec4(position, 1.0) + vec4(bunnyPosition, 0.0);

    // Calculates vector from the vertex to the light
    vec3 l = lightPosition - wpos.xyz;

    // Calculates the intensity of the light on the vertex
    intensity = dot(normalize(l), normal);

    // Use normal as the color, pass is to fragment shader
    interpolatedNormal = normal;

    // Scale matrix
    mat4 S = mat4(10.0);
    S[3][3] = 1.0;

    /* You need to calculate rotation matrix here */
    vec2 v1;
    v1.x = -1.0;
    v1.y = 0.0;

    vec2 v2;
    v2.x = armadilloPosition.x - 0.0;
    v2.y = 3.0;
    v2 = normalize(v2);


  float theta= acos((dot(v1,v2))/(length(v1)*length(v2)));

    mat4 R = mat4(0.0);
    R[0] = vec4(cos(theta), 0.0, -sin(theta), 0.0);
    R[1] = vec4(0.0, 1.0, 0.0, 0.0);
    R[2] = vec4(sin(theta), 0.0, cos(theta), 0.0);
    R[3] = vec4(0.0, 0.0, 0.0, 1.0);


    // Translation matrix
    mat4 T = mat4(1.0);
    T[3].xyz = bunnyPosition;
    T[3].x = bunnyPosition.x + armadilloPosition.x/2.0;

    gl_Position = projectionMatrix * viewMatrix * T * S * R * vec4(position, 1.0);
}
