#version 300 es

// Shared variable passed to the fragment shader
out float segment;
out vec3 interpolatedNormal;

uniform float rot_angle;
uniform vec3 bunnyPosition;

void main() {
    // Colorize bunny use the normal
    interpolatedNormal = normal;

    // Provided information, do not need to change
    vec3 o_left_ear = vec3(-0.055, 0.155, 0.0126); // origin for the left ear frame
    vec3 t_left_ear = vec3(-0.0111, 0.182, -0.028); // the top point on the left ear
    vec3 o_right_ear = vec3(-0.077, 0.1537, -0.0023); // origin for the right ear frame
    vec3 t_right_ear = vec3(-0.0678, 0.18, -0.058); // the top point on the right ear
    vec3 normal_left_ear = t_left_ear-o_left_ear; // approximated normal from the origin of the left ear frame
    vec3 normal_right_ear = t_right_ear-o_right_ear; // approximated normal from the origin of the right ear frame

    // Scale matrix
    mat4 S = mat4(10.0);
    S[3][3] = 1.0;

    // Translation matrix
    mat4 T = mat4(1.0);
    T[3].xyz = bunnyPosition ;

    mat4 TL = mat4(1.0);
    TL[3].xyz = o_left_ear;

    mat4 TLinverse = inverse(TL);

    mat4 TR = mat4(1.0);
    TR[3].xyz = o_right_ear;

    mat4 TRinverse = inverse(TR);

    /* Your codes start here */

    vec3 vLeft = position - o_left_ear;
    float angleLeft = acos((dot(vLeft,normal_left_ear))/(length(vLeft)*length(normal_left_ear)));

    vec3 vRight = position - o_right_ear;
    float angleRight = acos((dot(vRight,normal_right_ear))/(length(vRight)*length(normal_right_ear)));

    segment = 0.0 ; //Replace me
    if (angleLeft <0.8 || angleRight<0.8 ) {
    segment = 1.0;
    }

    mat4 R = mat4(0.0);
    R[0] = vec4(cos(rot_angle), 0.0, -sin(rot_angle), 0.0);
    R[1] = vec4(0.0, 1.0, 0.0, 0.0);
    R[2] = vec4(sin(rot_angle), 0.0, cos(rot_angle), 0.0);
    R[3] = vec4(0.0, 0.0, 0.0, 1.0);

    // If the current vertex is in Ear frame, modify this, if not, keep this.
    vec3 pos = position;

if (angleLeft <0.8) { // left-ear
    gl_Position = projectionMatrix * modelViewMatrix * T *
    TL * R  * TLinverse *
     S  * vec4(position, 1.0);
    }
    else if (angleRight <0.8) {  //right-ear
        gl_Position = projectionMatrix * modelViewMatrix * T *
        TR * R * TRinverse *
        S  * vec4(position, 1.0);
    }
    else {
            gl_Position = projectionMatrix * modelViewMatrix * T * S * vec4(position, 1.0);
    }
}
