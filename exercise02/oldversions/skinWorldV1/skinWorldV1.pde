/*
Version: 1
Date: 09-22-2021
Description:
setting up the screen & 3d terrain.
I BASICALLY COPIED THIS VID: https://www.youtube.com/watch?v=IKB1hWWedMk
*/

int cols, rows;
int scale = 30;
int w = 960;
int h = 720;

//movement
float flying = 0;

//2d array to contain z values
float[][] terrain;

void setup() {
  size(960,720,P3D);
  //# of columns & rows of triangles to be shown
  cols = w/scale;
  rows = h/scale;
  
  //create random z values in array to be used when drawing
  terrain = new float[cols][rows];

}

void draw(){
  background(127);
  stroke(127,0,0);
  noFill();
  
  flying -= 0.01;
  
  //loop to create z values
  float yOffset = flying;
  for (int y = 0; y < rows; y++) {
    float xOffset = flying;
    for (int x = 0; x < cols; x++) {
      //random parameters determine how bumpy terrain is
      //terrain[x][y] = random(-7.5,7.5);
      terrain[x][y] = map(noise(xOffset,yOffset),0,1,-100, 100);
      xOffset += 1;
    }
    yOffset += 1;
  }
  
  //rotate & translate grid to view it
  translate(width/2,height/2);
  rotateX(PI/3);
  translate(-w/2,-h/2);
  
  //create grid
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
