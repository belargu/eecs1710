/**
cointains creature class.
lore: you ran over the creature at the beginning of level1 & it comes back from the dead to chase you in level3
 */

class Creature {
  PVector pos;
  PImage body, limbs;
  float angle;
  float rotateSpeed = 10;

  Creature(float tempX, float tempY) {
    pos = new PVector(tempX, tempY);
    body = loadImage("creature\\body.png");
    limbs = loadImage("creature\\limbs.png");
  }

  void draw() {
    //rotating limbs
    pushMatrix();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    angle+=rotateSpeed;
    rotate(radians(angle));
    image(limbs, pos.x/width, pos.y/height);
    popMatrix();
    
    image(body, pos.x, pos.y);
  }
}
