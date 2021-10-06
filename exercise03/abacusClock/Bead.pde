class Bead {
  PImage[] colors = {loadImage("red.png"),loadImage("orange.png"),loadImage("yellow.png"),
    loadImage("green.png"),loadImage("blue.png")};
  PImage image; 
  
  float x,y;
  
  Bead(int colorIdx, float tempX, float tempY) {
    image = colors[colorIdx];
    x = tempX;
    y = tempY;
  }
  
  void draw() {
    image(image,x,y);
    ;
  }
}
