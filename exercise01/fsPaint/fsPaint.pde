/**
9/15/2021
current problem: the mouse drawing part won't show up, ui completely covers it?
even tho part of the screen is left transparent?
UPDATE I FIXED IT it's bc i put noStroke() in ui object apparently that disables
strokes for everything

9/16/2021
figured out how to draw the list of color buttons

*/

//ui colors
color uiGray = color(240,240,240);
color uiOutline = color(200,200,200);
color bgBlue = color(205,214,229);

//mspaint colors
color black = color(0);
color white = color(255);
color darkGray = color(127);
color lightGray = color(195);
color red = color(237,28,36);
color orange = color(255,127,39);
color yellow = color(255,242,0);
color lime = color(181,230,29);
color green = color(34,177,76);
color blue = color(0,162,232);
color indigo = color(63,72,204);
color purple = color(163,73,164);
color pink = color(255,174,201);
color brown = color(185,122,87);

color[] colorList = {black,white,darkGray,lightGray,red,orange,yellow,lime,green,
blue,indigo,purple,pink,brown};

//create ui object
UserInterface ui = new UserInterface();

//create button list
ColorBtn[] btnList;

//brush defaults
color brushColor = black;
float brushWidth = 10;

/**----------the part where things happen----------*/

void setup() {
  size(960,720,P2D);
  background(white);
  
  //add btns to btnList
  btnList = new ColorBtn[14];
  int listNum = 0;
  for (int x=8; x<=749; x+=57) { 
    btnList[listNum]= new ColorBtn(x,6,colorList[listNum]);
    listNum+=1;   
  }
}

void draw() { 
  
  //all clicking
  if (mousePressed) {
    //draw within canvas
    if (mouseX>5 && mouseX<805 && mouseY>91 && mouseY<691) {
      fill(brushColor);
      stroke(brushColor);
      strokeWeight(0);
      ellipse(mouseX,mouseY,brushWidth,brushWidth);
      strokeWeight(brushWidth);
      line(mouseX,mouseY,pmouseX,pmouseY);
    }
    
    //click ColorBtn to change lineColor
    for (int i=0; i<=13; i+=1) {
      if (mouseX>btnList[i].posX && mouseX<btnList[i].posX+51 
      && mouseY>btnList[i].posY && mouseY<btnList[i].posY+73) {
        brushColor = btnList[i].btnColor; 
      }
    }

    //click save button to save image
    if (mouseX>width-77 && mouseX<width-77+69 && mouseY>8 && mouseY<8+69) {
      PImage croppedImage = get(5,91,800,600);
      croppedImage.save("image.jpg");
    }
        
  }
  
  //ui
  ui.draw();
  
  //color buttons
  for (int i=0; i<=13; i+=1) {
    btnList[i].draw();
  }
  
  //save btn; too lazy to make it an object
  stroke(uiOutline);
  strokeWeight(7);
  rect(width-77,8,69,69);
  stroke(255);
  strokeWeight(4);
  fill(0,0,255);
  rect(width-77,8,69,69);
  strokeWeight(8);
  line(width-50,65,width-65,50);
  line(width-50,65,width-20,20);
  
}

/**----------CLASSES----------*/

class UserInterface {
  void draw() {
    fill(uiGray);
    stroke(uiOutline);
    strokeWeight(2);
    rect(0,0,width,85);
    rect(0,(height-25),width,25);
    
    //bg
    fill(bgBlue);
    strokeWeight(0);
    rect(0,86,width,5);
    rect(0,91,5,600);
    rect(0,(height-30),width,5);
    rect(806,91,(width-806),600);
    
    //text
    fill(black);
    text("800 x 600px",6,(height-8.5));
    text("made by patty",(width-90),(height-8.5));
    
  }
}

//button object code
class ColorBtn {
  int posX;
  int posY;
  color btnColor;
  int btnWidth = 51;
  int btnHeight = 73;
  
  ColorBtn(int tempX, int tempY, color btnCol) {
    posX = tempX;
    posY = tempY;
    btnColor = btnCol;
  }
  
  void draw() {
    fill(btnColor);
    strokeWeight(2);
    rect(posX,posY,btnWidth,btnHeight);
  }

}


/**----------FUNCTIONS----------*/

//toggle brushWidth with scroll
void mouseWheel(MouseEvent event) {
  if (brushWidth >= 1 && brushWidth < 25) {
    brushWidth += -(event.getCount());
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
