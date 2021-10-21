/**
 idk how else to name this. contains other levels such as the start screen, game over screen, & the end
 */

class StartScreen extends Level {
  int delay = 0;
  color[] colorList = {blue, darkBlue, darkRed, red};
  int colorIdx = 0;
  color meterColor;
  float meterWidth = 0;
  float acc = 0;
  PImage bg2 = loadImage("step.png");
  PImage currentBg;

  StartScreen() {
    bg = loadImage("letgo.png");
    currentBg = bg;
  }

  void draw() {
    image(currentBg, 0, 0);

    meterColor = colorList[colorIdx];

    //start meter
    //meter bg
    strokeWeight(2);
    stroke(meterColor);
    fill(0);
    rect(0, height*5/6, width, height/6);
    //the part of the meter that adds up
    strokeWeight(0);
    fill(meterColor);
    rect(0, height*5/6, meterWidth, height/6);
    fill(yellow);
    textAlign(CENTER);
    textSize(48);
    text("HOLD SPACE TO START", width/2, height-48);

    //go to level1 if meter full
    if (meterWidth >= width) {
      currentLevel = new Level1();
    } else if (meterWidth < 0) {
      meterWidth = 0;
      acc = 0;
    }

    holdToStart();

    //add to counter to change meter color
    delay++;
    //revert back to 0 if out of bounds; prevent crashing
    if (colorIdx == 4) {
      colorIdx = 0;
    }
  }

  //hold space to start level1; also quick tutorial to show how acceleration works
  void holdToStart() {
    if (keyPressed && key == ' ') {
      acc+= 0.025;
      currentBg = bg2;
      //only cycle through colors when holding space
      if (delay > 10) {
        colorIdx++;
        delay = 0;
      }
    } else {
      acc-= 0.05;
      colorIdx = 0;
      currentBg = bg;
    }

    meterWidth+=acc;
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
    while (delay<50 && prevLevelNum != 2) {
      imageMode(CORNER);
      image(bg,0,0);
      
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
  GameLevel prevLevel;
  int delay = 0;
  color[] colorList = {darkBlue, blue, darkBlue, black, darkRed, red, darkRed, black};
  int idxStart = 0;
  int colorIdx;

  GameOver(GameLevel tempLevel) {
    //pass GameLevel in parameters to use to go back
    prevLevel = tempLevel;
    if (tempLevel.levelNum == 2) {
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
      currentLevel = prevLevel;
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
