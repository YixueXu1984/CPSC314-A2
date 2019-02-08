out vec3 color;
uniform vec3 offset;
uniform vec3 eggPosition;
uniform vec3 armadilloPosition;

#define MAX_EYE_DEPTH 0.05

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);


  mat4 S = mat4(0.1);
  S[3][3] = 1.0;

  /* YOUR CODES HERE: move and rotate eyes corresponding to the movement of armadillo */

// todo: y-axis rotate
//
      mat4 xR = mat4(0.0);
      xR[0] = vec4(1.0, 0.0, 0.0, 0.0);
      xR[1] = vec4(0.0, cos(-1.57), sin(-1.57), 0.0);
      xR[2] = vec4(0.0, -sin(-1.57), cos(-1.57), 0.0);
      xR[3] = vec4(0.0, 0.0, 0.0, 1.0);


//todo: look at matrix
          vec3 up = vec3(0.0, 1.0, 0.0);
          vec3 zVector = normalize(armadilloPosition+offset - eggPosition);
          vec3 xVector = normalize(cross(up,zVector));
          vec3 yVector = normalize(cross(zVector, xVector));

      mat4 lookAtMatrix = mat4(vec4(xVector,0.0),
                               vec4(yVector,0.0),
                               vec4(zVector,0.0),
                               vec4(0.0, 0.0, 0.0, 1.0));



  mat4 T = mat4(1.0);
  T[3].x = offset.x + armadilloPosition.x ;
  T[3].y = offset.y + armadilloPosition.y -1.0;
  T[3].z = offset.z + armadilloPosition.z;


  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  gl_Position = projectionMatrix * viewMatrix * T * lookAtMatrix * xR * S * vec4(position,1.0);
}


