/**
Date: 11-10-2021

Description:
i wanted to make a program that edits parameters & dithers the result in real time.
i dither a lot of images and it takes forever to do because i have to manually click
so many sliders & filters on gimp/photoshop
i usually turn down brightness & up contrast & saturation because dithered images
look lighter up close
this will be very useful to me

References:
Daniel Shiffman's dithering video:
https://www.youtube.com/watch?v=0L2n8Tg2FwI

highlight/shadow:
https://stackoverflow.com/questions/51591445/what-is-the-algorithm-behind-photoshops-highlight-or-shadow-alteration

contrast/brightness:
https://forum.processing.org/one/topic/increase-contrast-of-an-image.html

saving to desktop:
https://forum.processing.org/one/topic/saving-to-desktop.html

resize screen:
https://forum.processing.org/one/topic/is-there-a-way-to-resize-the-display-window-during-the-program-execution.html

*/

//CHANGE THIS STRING to dither whatever image you want
//must be in data folder
String fileName = "bird.jpg";
//change this int to scale
int outputHeight = 600;

PImage filteredImg, ditheredImg, img;
boolean starting = true;

int scrollVal = 0;
int imgsSaved = 0;

void setup() {
  //orig img 
  img = loadImage(fileName);
  img.resize(0,outputHeight);
  
  filteredImg = loadImage(fileName);
  filteredImg.resize(0,outputHeight);
  
  //ditheredImg will be declared in update()
  
  size(960,480,P2D);
  //resize screen relative to img
  surface.setResizable(true);
  surface.setSize(img.width*2,img.height);
  background(0);  
}

void draw() {
  //init filtered.png
  if (starting) {
    update(img.width/2,img.height/2); 
    starting = false;
  }
  
  //draw filtered img
  image(filteredImg,0,0);
  
  //dithered img
  dither(ditheredImg);
  image(ditheredImg,width/2,0);
  
  //check for mousepressed in here too even tho there's a fcn
  //because i want to click & drag; fcn only detects on click
  //mouseDragged() didn't work the way i wanted it to
  if (mousePressed && mouseButton == LEFT && mouseX <= img.width) {
    update(mouseX,mouseY);
  }

}

//redither image when called (clicking)
void update(int xPos, int yPos) {
  //filter
  hueSatBri(scrollVal*5,xPos,yPos,img,filteredImg);
  image(filteredImg,0,0);
  
  //create filtered.png for ditheredImg to work with
  PImage export = get(0,0,img.width,img.height);
  export.save("data\\filtered.png");
  
  ditheredImg = loadImage("filtered.png");
  
}

//right click on dithered img = save img
void mousePressed() {
  if (mouseButton == RIGHT && mouseX > width/2) {
    imgsSaved++;
    PImage export = get(width/2,0,img.width,img.height);
    export.save("dithered_"+imgsSaved+".png");
    print("image saved \n");
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (mouseX < img.width) { //hue
    scrollVal+=e;
  }
}
