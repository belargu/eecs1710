/**
 idk how else to name this. contains other levels such as the start screen, game over screen, & the end
 */

class StartScreen extends Level {
  PImage bg2 = loadImage("step.png");
  PImage currentBg;

  Meter meter;

  StartScreen() {
    bg = loadImage("letgo.png");
    currentBg = bg;
    meter = new Meter();
  }

  void draw() {
    image(currentBg, 0, 0);

    meter.draw();

    fill(yellow);
    textAlign(CENTER);
    textSize(48);
    text("HOLD SPACE TO START", width/2, height-48);
    fill(darkYellow);
    textSize(18);
    text("there are no brakes.",width/2,170);

    //go to level1 if meter full
    if (meter.fullness >= width) {
      currentLevel = new Level1();
    } else if (meter.fullness < 0) {
      meter.fullness = 0;
      meter.vel = 0;
    }

    holdToStart();
  }

  //hold space to start level1; also quick tutorial to show how acceleration works
  void holdToStart() {
    if (keyPressed && key == ' ') {
      meter.vel+= 0.025;
      currentBg = bg2;
    } else {
      meter.vel-= 0.05;
      meter.colorIdx = 0;
      currentBg = bg;
    }

    meter.fullness+=meter.vel;
  }
}

/*------------------------------------------------------------*/

class NextLevel extends Level {
  int prevLevelNum;
  int delay = 0;
  NextLevel(int tempNum) {
    prevLevelNum = tempNum;
    bg = loadImage("nextlevel.png");
  }

  void draw() {
    //draw this level for a while then move to next lvl
    //unless previous level was Level3, then go straight to TheEnd
    while (delay<25 && prevLevelNum != 2) {
      imageMode(CORNER);
      image(bg, 0, 0);

      fill(yellow);
      textAlign(CENTER);
      textSize(98);
      text("LEVEL" + (prevLevelNum+1) + "COMPLETED.", width/2+2, 68);

      textSize(48);
      text("loading next level...", width/2, height-32);

      delay++;
    }

    switch (prevLevelNum) {
    case 0:
      currentLevel = new Level2();
      break;
    case 1:
      currentLevel = new Level3();
      break;
    case 2:
      currentLevel = new TheEnd();
    }
  }
}

/*------------------------------------------------------------*/

class GameOver extends Level {
  int prevLevelNum;
  int delay = 0;
  color[] colorList = {darkBlue, blue, darkBlue, black, darkRed, red, darkRed, black};
  int idxStart = 0;
  int colorIdx;

  GameOver(int tempNum) {
    //pass a GameLevel's levelNum in parameters to use to go back
    prevLevelNum = tempNum;
    if (prevLevelNum == 2) {
      idxStart = 4;
      bg = loadImage("gameover2.png");
    } else {
      bg = loadImage("gameover.png");
    }
    colorIdx = idxStart;
  }

  void draw() { 
    //flashing bg code
    delay++;
    if (delay > 15) {
      colorIdx++;
      delay = 0;
    }
    //revert back to 0 if out of bounds; prevent crashing
    if (colorIdx == 8) {
      colorIdx = idxStart;
    }

    //draw the stuff
    fill(colorList[colorIdx]);
    rect(0, 0, width, height);
    imageMode(CORNER);
    image(bg, 0, 0);

    fill(yellow);
    textAlign(CENTER);
    textSize(165);
    text("GAMEOVER.", width/2+2, 110);

    textSize(48);
    text("press space to restart...", width/2, height-24);

    if (keyPressed && key == ' ') {
      switch (prevLevelNum) {
        case 0:
          currentLevel = new Level1();
          break;
        case 1:
          currentLevel = new Level2();
          break;
        case 2:
          currentLevel = new Level3();
          break;
      }
    }
  }
}

/*------------------------------------------------------------*/

class TheEnd extends Level {
  TheEnd() {
    bg = loadImage("theend.png");
  }

  void draw() {
    imageMode(CORNER);
    image(bg, 0, 0);

    fill(yellow);
    textAlign(CENTER);
    textSize(158);
    text("The End.", width/2, 150);
  }
}
