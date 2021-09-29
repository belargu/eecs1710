/**
 Date: 09-24-2021
 Description:
 this version has functions & bools for moving to allow multiple keys being pressed
 at once.
 
 Reference:
 I BASICALLY COPIED THIS VID: 
 https://www.youtube.com/watch?v=IKB1hWWedMk
 pressing multiple keys at once: 
 https://forum.processing.org/two/discussion/16594/can-multiple-keys-be-pressed-on-the-keyboard.html
 to be used ltr: 
 https://vormplus.be/full-articles/drawing-a-cylinder-with-processing
 ppl said to use this for render distance?:
 https://processing.org/reference/frustum_.html
 
 */

int cols, rows;
int scale = 20;

//movement
float velX = 0;
float velY = 0;
float moveSpeed;
float walk = 0.025;
float run = 0.05;
boolean isUp, isDown, isLeft, isRight, isFast, isTurn;

//2d array to contain z values
float[][] terrain;

void setup() {
  size(960, 720, P3D);
  //# of columns & rows of triangles to be shown
  cols = 100;
  rows = 100;

  //create random z values in array to be used when drawing
  terrain = new float[cols][rows];
}

void draw() {
  background(127);
  
  //text
  fill(64,32,0);
  textSize(15);
  textAlign(CENTER);
  text("Controls: WASD, +shift to run",width/2,20);
  
  //skin color
  stroke(64, 32, 0, 100);
  fill(200, 160, 127);

  //controls
  if (isFast == false)moveSpeed = walk;
  if (isFast)moveSpeed = run;
  if (isUp)velY -= moveSpeed;
  if (isDown)velY += moveSpeed;
  if (isLeft)velX -= moveSpeed;
  if (isRight)velX += moveSpeed;
  //if (isTurn)rotateY(PI/100);

  //loop to create z values
  float posY = velY;
  for (int y = 0; y < rows; y++) {
    float posX = velX;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(posX, posY), 0, 1, -50, 50);
      posX += .1;
    }
    posY += .1;
  }

  //rotate & translate grid to view it
  translate(width/2, height/2);
  rotateX(PI/2.5);
  translate(-width, -height*1.5, 80);

  //draw grid
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      //triangle_strips are drawn by plotting a zigzag
      vertex(x*scale, y*scale, terrain[x][y]);
      vertex(x*scale, (y+1)*scale, terrain[x][y+1]);
    }
    endShape();
  }
  
}

/*-----------FUNCTIONS-----------*/

void keyPressed() {
  setMove(keyCode, true);
}

void keyReleased() {
  setMove(keyCode, false);
}

boolean setMove(int k, boolean b) {
  switch (k) {
  case 87: //keycode for W
    return isUp = b;

  case 83: //keycode for S
    return isDown = b;

  case 65: //keycode for A
    return isLeft = b;

  case 68: //keycode for D
    return isRight = b;

  case SHIFT:
    return isFast = b;

  case LEFT:
    return isTurn = b;

  default:
    return b;
  }
}

class Hair {

}
