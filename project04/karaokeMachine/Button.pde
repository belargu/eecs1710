/**
button class & songButton class & sliderbtn (3 classes in 1 file to save space)
*/

class Button {
  String name;
  PVector pos;
  color color1 = YELLOW;
  color color2 = BLACK;
  
  Button(String tempName, int tempX, int tempY) {
    name = tempName;
    pos = new PVector(tempX,tempY);
  }
  
  void draw() {
    strokeWeight(2);
    stroke(color1);
    fill(color2);
    rect(pos.x,pos.y,150,45);
    textAlign(CENTER);
    textSize(30);
    fill(color1);
    text(name,pos.x+75,pos.y+30);
    
    
    //hover
    if (mouseX > pos.x && mouseX < pos.x+160 
    && mouseY > pos.y && mouseY < pos.y+45) {
      color1 = BLACK;
      color2 = YELLOW;
      
      //click
      if (mousePressed == true) {
        switch(name) {
          case "start":
            currentLevel = new SongSelect();
            break;
          case "callibrate":
            currentLevel = new Callibrate();
            break;
          case "exit":
            currentLevel = new Start();
            break;
          case "sing!":
            currentLevel = new Game();
            break;
          case "retry":
            currentLevel = new Game();
            //needs to be set false here since there's a button in the exact
            //same spot in the new currentLevel, & it still detects mousePressed
            //as true
            mousePressed = false;
            break;
          case "new song":
            currentLevel = new SongSelect();
            mousePressed = false;
            break;
        }
      }
    } else {
      color1 = YELLOW;
      color2 = BLACK;
    }   
  }

}

/*------------------------------------------------------------*/

class SongButton {
  String name, numString;
  int num;
  PVector pos;
  color color1 = GREEN;
  color color2 = BLACK;
  
  SongButton(String tempName, int tempNum, int tempX, int tempY) {
    name = tempName;
    num = tempNum;
    pos = new PVector(tempX,tempY);
    
  }
  
  void draw() {
    
    strokeWeight(2);
    //num box
    stroke(BLACK);
    fill(GREEN);
    rect(pos.x,pos.y,45,45);
    textAlign(CENTER);
    textSize(30);
    fill(BLACK);
    text(num+1,pos.x+22,pos.y+30);
    
    //clickable part
    stroke(color1);
    fill(color2);
    rect(pos.x+50,pos.y,240,45);
    textAlign(CENTER);
    textSize(24);
    fill(color1);
    text(name,pos.x+170,pos.y+30);
    
    //hover
    if (mouseX > pos.x+50 && mouseX < pos.x+300 
    && mouseY > pos.y && mouseY < pos.y+45) {
      color1 = BLACK;
      color2 = GREEN;
      
      //click
      if (mousePressed == true) {
        color1 = BLACK;
        color2 = WHITE;
        
        currentSong = songList[num];
        println(currentSong.fileName);
      }
    } else {
      color1 = GREEN;
      color2 = BLACK;
    }   
  } 
}

/*------------------------------------------------------------*/

class SliderButton {
  PVector pos;
  color color1 = BLACK;
  color color2 = RED;
  
  SliderButton(int x, int y) {
    pos = new PVector(x,y);
  }
  void draw() {
    ellipseMode(RADIUS);
    strokeWeight(2);
    stroke(color1);
    fill(color2);
    ellipse(pos.x,pos.y,20,20);
    
    //hover
    if (mouseX > pos.x-15 && mouseX < pos.x+15 
    && mouseY > pos.y-15 && mouseY < pos.y+15) {
      color1 = RED;
      color2 = WHITE;
      
      //click
      if (mousePressed == true) {
        pos.x = constrain(mouseX,205,605);
        threshold = map(pos.x,205,605,0,0.1);
      }
    } else {
      color1 = BLACK;
      color2 = RED;
    }
    
  }
}
