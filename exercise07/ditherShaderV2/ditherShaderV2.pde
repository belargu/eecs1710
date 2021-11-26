/**
Date: 11-25-2021
Description: 
i found a dithering glsl shader online... 




but i can't get it to work!

References:
based off Prof Fox Gieg's Shader02.pde
https://github.com/hughsk/glsl-dither
*/

PShader shader_thresh; 
PShader shader_dither;

void setup() {
  size(800, 600, P2D);
  
  setupCapture(0);
  /**
  shader_thresh = loadShader("shaders/thresh.glsl");
  shader_thresh.set("iResolution", float(width), float(height), 1.0);
  */
  shader_dither = loadShader("shaders/4x4.glsl");
}

void draw() {
  background(0);
  /**
  shader_thresh.set("threshold", 255 * ((float) mouseX / (float) width)); 
  shader_thresh.set("tex0", videoImg);
  filter(shader_thresh);
  */
  //shader_dither.set("vec2",videoImg);
  
  filter(shader_dither);

  surface.setTitle("" + frameRate);
}
