class StartScreen extends Level {
  int delay;
  color[] colorList = {blue, darkBlue, darkRed, red};
  int colorIdx = 0;
  color meterColor;
  float meterWidth = 0;
  float acc = 0;
  
  StartScreen() {
  }
  
  void draw() {
    fill(255,255,127);
    rect(0,0,width,height);
    
    meterColor = colorList[colorIdx];
    
    //start meter
    //meter bg
    strokeWeight(2);
    stroke(meterColor);
    fill(0);
    rect(0,height*5/6,width,height/6);
    //the part of the meter that adds up
    strokeWeight(0);
    fill(meterColor);
    rect(0,height*5/6,meterWidth,height/6);
    fill(yellow);
    textAlign(CENTER);
    text("HOLD SPACE TO START",width/2,height-48);
    
    if (meterWidth >= width) {
      currentLevel = new Level1();
    } else if (meterWidth < 0) {
      meterWidth = 0;
      acc = 0;
    }
    
    holdToStart();
    
    //add to counter to change meter color
    delay+=1;
    //revert back to 0 if out of bounds; prevent crashing
    if (colorIdx == 4) {
      colorIdx = 0;
    }
    
  }
  
  //hold space to start level1; also quick tutorial to show how acceleration works
  void holdToStart() {
    if (keyPressed && key == ' ') {
      acc+= 0.025;
      //only cycle through colors when holding space
      if (delay > 10) {
        colorIdx+=1;
        delay = 0;
      }
    } else {
      acc-= 0.05;
      colorIdx = 0;
    }
    meterWidth+=acc;
  }

}
