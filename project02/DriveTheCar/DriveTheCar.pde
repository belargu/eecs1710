/**
Date: 10-18-2021
Description:
  this is a car driving game.
  setting up levels/scenes, car ui
  
Reference:
  - 
   
*/
color red = color(255,0,0);
color darkRed = color(127,0,0);
color blue = color(0,0,255);
color darkBlue = color (0,0,127);
color yellow = color(255,255,0);
PFont times;

Level currentLevel;

void setup() {
  size(960,720,P2D);
  strokeWeight(0);
  times = createFont("Times New Roman",48);
  textFont(times);
  
  currentLevel = new StartScreen();
}

void draw() {

  currentLevel.draw();
   
}
