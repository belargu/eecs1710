color black = color(0,0,0);
color[] colorList = {color(255,0,0),color(255,255,0),color(0,255,0),
color(0,255,255),color(0,0,255),color(255,0,255),color(255,255,255)};
color randomColor = colorList[int(random(colorList.length))];

float brushWidth = 10;

void setup() {
  //uncomment when done to fullscreen
  //size(displayWidth,displayHeight,P2D);
  size(1600,900,P2D);
  background(black);
}

void draw() {
  //draw over previous frame 
  blendMode(SUBTRACT);
  fill(black,1);
  blendMode(BLEND);
  noStroke();
  rect(0,0,width,height);
  
  if (mousePressed && mouseButton == LEFT) {  
    fill(randomColor);
    ellipseMode(CENTER);
    ellipse(mouseX,mouseY,brushWidth,brushWidth);
    strokeWeight(brushWidth);
    stroke(randomColor);
    line(mouseX,mouseY,pmouseX,pmouseY);
  } 
}

//toggle brushWidth with scroll
void mouseWheel(MouseEvent event) {
  brushWidth += -(event.getCount()*3);
}

//change color whenever done clicking
void mouseReleased() {
  randomColor = colorList[int(random(colorList.length))];
}
