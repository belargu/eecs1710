/**
9/15/2021
created simple version without spoof UI
*/

//mspaint colors
color black = color(0);
color white = color(255);
color darkGray = color(127);
color lightGray = color(195);
color red = color(237,28,36);
color orange = color(255,127,39);
color yellow = color(255,242,0);
color green = color(34,177,76);
color blue = color(0,162,232);
color indigo = color(63,72,204);
color purple = color(163,73,164);
color pink = color(255,174,201);
color brown = color(185,122,87);

//brush defaults
color lineColor = black;
color fillColor = black;
float brushWidth = 10;

/**----------the part where things happen----------*/

void setup() {
  size(960,720,P2D);
  background(white);
}

void draw() { 
  //all clicking
  if (mousePressed) {
    strokeWeight(brushWidth);
    line(mouseX,mouseY,pmouseX,pmouseY);
    print("itworks!");
  }
  
}

/**----------CLASSES----------*/


//button object code


/**----------FUNCTIONS----------*/

//toggle brushWidth with scroll
void mouseWheel(MouseEvent event) {
  if (brushWidth >= 1 && brushWidth < 25) {
    brushWidth += -(event.getCount());
    print(""+brushWidth);
  }
  //speed up resizing when bigger
  if (brushWidth >= 25) {
    brushWidth += -(event.getCount()*2);
  }
  //prevent negative value
  else if (brushWidth < 1) {
  brushWidth =1;  
  }
}

//saving img code
