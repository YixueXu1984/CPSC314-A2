uniform vec3 eggPosition;
uniform vec3 armadilloPosition;
uniform vec3 offset;


void main() {

    vec3 eyePosition;
    eyePosition.x = armadilloPosition.x + offset.x;
    eyePosition.y = armadilloPosition.y + offset.y - 1.0;
    eyePosition.z = armadilloPosition.z + offset.z;

    float scale = length(eggPosition - eyePosition);

    mat4 scaleMatrix = mat4(vec4(1.0, 0.0, 0.0, 0.0),
                            vec4(0.0, scale, 0.0, 0.0),
                            vec4(0.0, 0.0, 1.0, 0.0),
                            vec4(0.0, 0.0, 0.0, 1.0));

      mat4 xR = mat4(0.0);
      xR[0] = vec4(1.0, 0.0, 0.0, 0.0);
      xR[1] = vec4(0.0, cos(-1.57), sin(-1.57), 0.0);
      xR[2] = vec4(0.0, -sin(-1.57), cos(-1.57), 0.0);
      xR[3] = vec4(0.0, 0.0, 0.0, 1.0);


        mat4 T = mat4(1.0);
        T[3].x = offset.x + armadilloPosition.x ;
        T[3].y = offset.y + armadilloPosition.y -1.0;
        T[3].z = offset.z + armadilloPosition.z;

          vec3 up = vec3(0.0, 1.0, 0.0);
          vec3 zVector = normalize(eyePosition - eggPosition);
          vec3 xVector = normalize(cross(up,zVector));
          vec3 yVector = normalize(cross(zVector, xVector));

      mat4 lookAtMatrix = mat4(vec4(xVector,0.0),
                               vec4(yVector,0.0),
                               vec4(zVector,0.0),
                               vec4(0.0, 0.0, 0.0, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * T * lookAtMatrix  *  xR *  scaleMatrix *  vec4(position, 1.0);
}