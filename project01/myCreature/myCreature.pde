/**
Date: 09-30-2021
Description:
  adding trust & health meters, adding inputs (left&right click), 
  adding creature movement
Reference:
  - Prof. Fox Gieg's Creature01.pde, Creature02.pde
  - processing.org/reference
  - for findNearestEdge(): 
    https://www.javatpoint.com/java-program-to-print-the-smallest-element-in-an-array
  - 

*/

//creating vars
Creature creature;
PVector position, target;
color yellow = color(255,255,0);
PFont times;
PImage bg;
float marginUp, marginDown, marginLeft, marginRight;

Food[] foodList;

//meters
Meter health = new Meter("HEALTH",10,10, color(255,0,0),0.75);
Meter trust = new Meter("TRUST",875,10, color(0,0,255),0.5);

void setup() {
  size(960,720,P2D);
  creature = new Creature();
  
  times = createFont("Times New Roman",72);
  bg = loadImage("grass.png");
  
  //create margins
  marginUp = 5;
  marginDown = height-5;
  marginLeft = 80;
  marginRight = width-80;
  
  ellipseMode(CENTER);
}

void draw() {
  background(bg);
 
  creature.draw();
    
  //ui
  health.draw();
  trust.draw();


  //creature conditionals
  if (health.value <= 0) {
    creature.dead = true;
  }
  
  if (trust.value <= 0)  {
    creature.escape = true;
  }
}

/*-----------FUNCTIONS-----------*/

void mousePressed() {
  if (mouseButton == LEFT) {
    //hitting
    if (mouseX>creature.pos.x-50 && mouseX<creature.pos.x+50 && 
    mouseY>creature.pos.y-50 && mouseY<creature.pos.y+50) {
      health.value-=0.01;
      print("hit\n");
    }
    //scaring
    else {
      trust.value-=0.05;
      print("scare\n");
    }
  } 
  else if (mouseButton == RIGHT) {
    //petting
    if (mouseX>creature.pos.x-50 && mouseX<creature.pos.x+50 && 
    mouseY>creature.pos.y-50 && mouseY<creature.pos.y+50) {
      trust.value+=0.01;
      print("pet\n");
    }
    //placing food
    else {
      print("food\n");
    }

  } 
}
