/**
 contains meter class. used in startscreen & gamelevels
 */

class Meter {
  int delay = 0;
  int colorIdx = 0;
  color meterColor;
  float fullness = 0;

  void draw() {
    //revert back to 0 if out of bounds; prevent crashing
    if (colorIdx == 6) {  
      colorIdx = 0;
    }
    meterColor = colorList[colorIdx];

    //start meter
    //meter bg
    strokeWeight(2);
    stroke(meterColor);
    fill(BLACK);
    rect(1, height-46, width-2, 45);
    
    //the part of the meter that adds up
    strokeWeight(0);
    fill(meterColor);
    rect(1, height-46, fullness, 45);
    
    flash();
    
  }

  void flash() {
    delay++;
    //cycle through colors
    if (delay > 10 && colorIdx < 6) {
      colorIdx++;
      delay = 0;
    }
  }
  
}
