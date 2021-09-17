color bellYellow = color(255,204,0);

void setup() {
  //uncomment when done to fullscreen
  //size(displayWidth,displayHeight,P2D);
  size(1600,900,P2D);
  background(bellYellow);
}

void draw() {
  //draw over previous frame 
  fill(bellYellow);
  strokeWeight(0);
  rect(0,0,width,height);
  
  /**
  //the circle
  ellipseMode(CENTER);
  fill(255,238,0);
  strokeWeight(7);
  ellipse(mouseX,mouseY,circleWidth,circleWidth);
  */
}

class Smiley {
  
  //var setup
  float circleWidth = 150;
  color circleColor = color(255,238,0);
  color eyeColor = color(255,0,0);
  float posX, posY;
  
  //making the circle
  

}
