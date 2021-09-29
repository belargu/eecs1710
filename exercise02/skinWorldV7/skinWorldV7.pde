/**
 Date: 09-28-2021
 Description:
 final version of skinWorld with everything working
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

//2d array of hair objects. a random amt of them will not contain hair. will be
//compared with terrain array
Hair[][] hairArray;

void setup() {
  size(960, 720, P3D);
  //# of columns & rows of triangles to be shown
  cols = 100;
  rows = 100;

  //create empty float vars (z) in array to be used when drawing
  terrain = new float[cols][rows];
  //same with hair
  hairArray = new Hair[cols][rows];
  
  //loop to create hairs
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      //2% chance that vertex will have hair
      if (int(random(1,51))==50) {
        hairArray[x][y] = new Hair((x*scale),(y*scale),-50);
      }
    }
  }
  
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
  if (isRight)velX += moveSpeed;
  if (isLeft)velX -= moveSpeed;


  //loop to create z values
  //loop also moves all points since it uses velX & velY
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
  strokeWeight(1);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      //triangle_strips are drawn by plotting a zigzag
      vertex(x*scale, y*scale, terrain[x][y]);
      vertex(x*scale, (y+1)*scale, terrain[x][y+1]);
    }
    endShape();
  }
  
  //draw hair
  for (int y = 0; y < rows-1; y++) {
    for (int x = 0; x < cols; x++) {
      //check if hair exists; if it does, draw
      if (hairArray[x][y] == null){
        ;
      }
      else {
        hairArray[x][y].draw();
        hairArray[x][y].move();
      }
    }
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

  default:
    return b;
  }
}

/*-----------CLASSES-----------*/

class Hair {
  float x, y, z;
  //make a random # of hair segments
  int hairSegs = int(random(15,26));
  //make array of hair segment coords
  float[][] hairCoords = new float[hairSegs][];
  
  Hair(float tempX, float tempY, float tempZ) {
    x = tempX;
    y = tempY;
    z = tempZ;
    
    //create coordinates of hair in jagged array
    float nextX = x;
    float nextY = y;
    float nextZ = z;
    for (int i=0; i<hairSegs; i++) {
      hairCoords[i] = new float[]{nextX,nextY,nextZ};
      //prepare for next set of coords
      nextX+=random(0,2);
      nextY+=random(0,2);
      nextZ+=scale/2; 
    }
  }
  
  void draw() {  
    stroke(0);
    float tempWeight = 10;
    strokeWeight(tempWeight);

    //use loop to draw line upwards
    for (int i=0; i<hairSegs-1; i++) {
      line(hairCoords[i][0],hairCoords[i][1],hairCoords[i][2],
      hairCoords[i+1][0],hairCoords[i+1][1],hairCoords[i+1][2]); 
      
      tempWeight-=tempWeight/(hairSegs-1);
      tempWeight*=.9;
      strokeWeight(tempWeight);
    }

  }
  
  void move() {
    for (int i=0; i<hairCoords.length; i++) {
      //idk why i need to multiply movespeed but otherwise the hairs move very slowly
      if (isUp) hairCoords[i][1]+=moveSpeed*200;
      if (isDown) hairCoords[i][1]-=moveSpeed*200;
      if (isRight) hairCoords[i][0]-=moveSpeed*200;
      if (isLeft) hairCoords[i][0]+=moveSpeed*200;

    }
  }   
}
