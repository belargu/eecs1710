class Meter {
  float x, y;
  color meterColor;
  float value;
  String name;
  
  //constructor
  Meter(String tempName, float tempX, float tempY, color tempColor, float tempVal) {
    x = tempX;
    y = tempY;
    name = tempName;
    meterColor = tempColor;
    //use 0-1 rather than 0-100 for meter value
    value = tempVal;
  }
  
  void draw() {
    rectMode(CORNERS);
    //bg meter layer
    //if full, stroke is yellow
    if (value < 1) {
      strokeWeight(1);
      stroke(meterColor);
    } else {
      strokeWeight(2);
      stroke(yellow);
    }
    fill(0);
    rect(x,y,x+75,height-y);
    
    //meter val layer
    strokeWeight(0);
    fill(meterColor);
    rect(x,y+(height-20-((height-20)*value)),x+75,height-y);
    
    //text
    fill(yellow);
    textSize(72);
    textFont(times);

    
    //rotate text depending on location
    if (x <= width/2) {
      pushMatrix();
      rotate(radians(270));
      text(name,-(width/2)-20,72);
      popMatrix();
    }
    else if (x > width/2) {
      pushMatrix();
      rotate(radians(90));
      text(name,width/4,-890);
      popMatrix();
    }
    
    //make sure value never goes past 0 or 1
    if (value < 0) {
      value = 0;
    }
    else if (value > 1) {
      value = 1;
    }
    
  }
}
