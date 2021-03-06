#version 300 es

precision highp float;
precision highp int;

out vec4 out_FragColor;

in float intensity;

void main() {
  out_FragColor = vec4(intensity*vec3(1.0), 1.0); 
}
