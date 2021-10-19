class Wheel {
  PVector pos;
  float vel = 0;
  PImage img;
  
  Wheel(float tempX, float tempY) {
    pos = new PVector(tempX,tempY);
    img = loadImage("wheel.png");
  }
  
  void draw() {
    //rotating 
    imageMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(radians(vel));
    image(img,pos.x/width,pos.y/height);
    popMatrix();
  }
}
