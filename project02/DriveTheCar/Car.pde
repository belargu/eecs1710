/**
 contains car & wheel classes
 */

class Car {
  PVector pos;
  float dist = 0;
  float vel = 0;
  PImage img;
  PVector[] vertices = new PVector[4];

  Wheel[] wheels = new Wheel[2];

  Car(float tempX, float tempY) {
    pos = new PVector(tempX, tempY);
    img = loadImage("car.png");

    //create wheels 
    int temp = 28;
    for (int i=0; i<2; i++) {
      wheels[i] = new Wheel(pos.x+temp+36, pos.y+168+36);
      temp+= 185;
    }

    //hitbox coords
    vertices[0] = new PVector(pos.x+60,pos.y+160);
    vertices[1] = new PVector(pos.x+img.width,pos.y+160);
    vertices[2] = new PVector(pos.x+img.width-60,pos.y+img.height);
    vertices[3] = new PVector(pos.x,pos.y+img.height);
    
  }

  void draw() {
    fill(203, 21, 0);
    imageMode(CORNER);
    image(img, pos.x, pos.y);
    
    /**
    //rect hitbox representation
    noStroke();
    beginShape();
    for (PVector v : vertices) {
      vertex(v.x, v.y);
    }
    endShape();
    */

    for (Wheel i : wheels) {
      i.draw();
    }
  }

  void move() {
    //controls
    if (keyPressed && key == ' ') {
      vel+= 0.1;
      //print(vel+"\n");
      //print(dist+"\n");
    } else {
      vel-= 0.1;
      //print(vel+"\n");
    }
    if (vel < 0) {
      vel = 0;
      //print(vel+"\n");
    }

    dist+=vel;
    for (Wheel i : wheels) {
      i.vel+=vel;
    }
    ;
  }
}

/*------------------------------------------------------------*/

class Wheel {
  PVector pos;
  float vel = 0;
  PImage img;

  Wheel(float tempX, float tempY) {
    pos = new PVector(tempX, tempY);
    img = loadImage("wheel.png");
  }

  void draw() {
    //rotating 
    pushMatrix();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    rotate(radians(vel));
    image(img, pos.x/width, pos.y/height);
    popMatrix();
  }
}
