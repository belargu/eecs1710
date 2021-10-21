/**
 contains meter class. used in startscreen & gamelevels
 */

class Meter {
  int delay = 0;
  color[] colorList = {blue, darkBlue, darkRed, red};
  int colorIdx = 0;
  color meterColor;
  float fullness = 0;
  float vel = 0;

  void draw() {
    //revert back to 0 if out of bounds; prevent crashing
    if (colorIdx == 4) {  
      colorIdx = 0;
    }
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
    rect(0, height*5/6, fullness, height/6);

    if (keyPressed && key == ' ') {
      flash();
    } else {
      colorIdx = 0;
    }
  }

  void flash() {
    delay++;
    //cycle through colors
    if (delay > 10 && colorIdx < 4) {
      colorIdx++;
      delay = 0;
    }
  }
}
