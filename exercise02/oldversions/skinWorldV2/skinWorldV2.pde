/*
Version: 2
Date: 09-22-2021
Description:
I BASICALLY COPIED THIS VID: https://www.youtube.com/watch?v=IKB1hWWedMk
pressing multiple keys at once: https://forum.processing.org/two/discussion/16594/can-multiple-keys-be-pressed-on-the-keyboard.html
to be used ltr: https://vormplus.be/full-articles/drawing-a-cylinder-with-processing

this version uses perlin noise instead of random. i will also attempt to move
terrain around with WASD
*/

int cols, rows;
int scale = 20;

//movement
float flyingX = 0;
float flyingY = 0;
float moveSpeed = 0.01;

//2d array to contain z values
float[][] terrain;

void setup() {
  size(960,720,P3D);
  //# of columns & rows of triangles to be shown
  cols = width/scale;
  rows = height/scale;
  
  //create random z values in array to be used when drawing
  terrain = new float[cols][rows];

}

void draw(){
  background(127);
  stroke(127,0,0);
  fill(150,127,127);
  
  //controls
  if (keyPressed) {
    if (key == 'w') {
      flyingY -= moveSpeed;
    }
    else if (key == 's') {
      flyingY += moveSpeed;
    }
    if (key == 'a') {
      flyingX -= moveSpeed;
    }
    else if (key == 'd') {
      flyingX += moveSpeed;
    }
  }
  
  //loop to create z values
  float yOffset = flyingY;
  for (int y = 0; y < rows; y++) {
    float xOffset = flyingX;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xOffset,yOffset),0,1,-100, 100);
      xOffset += .1;
    }
    yOffset += .1;
  }
  
  //rotate & translate grid to view it
  translate(width/2,height/2);
  rotateX(PI/3);
  translate(-width/2,-height/2);
  
  //draw grid
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      //triangle_strips are drawn by plotting a zigzag
      vertex(x*scale,y*scale,terrain[x][y]);
      vertex(x*scale,(y+1)*scale,terrain[x][y+1]);
      
    }
    endShape();
  }
}

/*-----------FUNCTIONS-----------*/
