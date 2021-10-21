/**
 Date: 10-20-2021
 Description:
 made a lot of assets yesterday & today.
 
 things to try to do today:
 - implement parallax
 - create obstacle class & subclasses
 - use the assets
 
 Reference:
 - parallelogram hitbox/collision:
 http://www.jeffreythompson.org/collision-detection/poly-rect.php
 - parallax:
 https://openprocessing.org/sketch/46976/#
 
 
 */
color black = color(0);
color white = color(255);
color red = color(255, 0, 0);
color darkRed = color(130, 0, 0);
color blue = color(0, 0, 255);
color darkBlue = color (0, 0, 130);
color yellow = color(255, 255, 0);
color darkYellow = color(130,130,0);
PFont times;

Level currentLevel;
int currentLevelNum = 0;

void setup() {
  size(960, 720, P2D);
  strokeWeight(0);
  times = createFont("Times New Roman", 256);
  textFont(times);


  currentLevel = new StartScreen();
  //test
  //currentLevel = new GameOver(new Level1());
  //currentLevel = new NextLevel(1);
}

void draw() {

  currentLevel.draw();
}
