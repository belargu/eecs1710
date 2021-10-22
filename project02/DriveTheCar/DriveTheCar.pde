/**
 Date: 10-22-2021
 Description:
   this version has been playtested a bit.
   
   extra things to add if i have time:
   - sound
   - smoother transitions btwn levels (fade in/out)
   - more obstactle types
 
 Reference:
 - parallelogram hitbox/collision:
 http://www.jeffreythompson.org/collision-detection/poly-rect.php
 - 2 rect collision: (scrapped)
 https://happycoding.io/tutorials/processing/collision-detection
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
color darkYellow = color(130, 130, 0);
PFont times;

Level currentLevel;

void setup() {
  size(960, 720, P2D);
  strokeWeight(0);
  times = createFont("Times New Roman", 200);
  textFont(times);

  currentLevel = new StartScreen();
  //test
  //currentLevel = new Level3();
}

void draw() {

  currentLevel.draw();
}
