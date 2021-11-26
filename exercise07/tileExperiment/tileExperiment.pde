/** 
Date: 11-25-2021
Description:
messing around with tiles and shaders... during the time of writing this idk what
shaders have anything to do with the exercise prompt... but i will learn

References: 
truchet tile code copied from this: 
https://www.marginallyclever.com/2020/06/masked-and-weighted-truchet-tiles-in-processing/

*/

int tileSize = 60;
int lineSpacing = 10;

void tileA(int x0,int y0) {
  int x1=x0+tileSize;
  int y1=y0+tileSize;
  
  for(int x=0;x<tileSize;x+=lineSpacing) {
    line(x0+x,y0,x0,y0+x);
    line(x0+x,y1,x1,y0+x);
  }
}

// style=\
void tileB(int x0,int y0) {
  int x1=x0+tileSize;
  int y1=y0+tileSize;
  
  for(int x=0;x<tileSize;x+=lineSpacing) {
    line(x0+x,y0,x1,y1-x);
    line(x0+x,y1,x0,y1-x);
  }
}

//triangles
void triA(int x0, int y0) {
  beginShape();
  vertex(x0,y0);
  vertex(x0+tileSize,y0);
  vertex(x0,y0+tileSize);
  endShape();
}

/**----------------------------*/

void setup() {
  size(600,600);
  fill(0);
  stroke(0);
  background(255);
  
  for(int y=0;y<height;y+=tileSize) {
    for(int x=0;x<width;x+=tileSize) {
      /**
      int val = int(random(3));
      switch(val) {
        case 0:
          tileA(x,y);
          break;
        case 1:
          tileB(x,y);
          break;
        case 2:
          triA(x,y);
          break;
      }
      */

      int t = floor(random(2));
      if(0==t) tileA(x,y);
      else     tileB(x,y);

    }
  }
}

void draw() {
  ;
}
