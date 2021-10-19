class GameOver extends Level {
  GameLevel prevLevel;
  
  
  
  GameOver(GameLevel tempLevel) {
    //pass GameLevel in parameters to use to go back
    prevLevel = tempLevel;
  }
  
  void draw() {
    fill(red);
    rect(0,0,width,height);
    
    if (keyPressed && key == ' ') {
      currentLevel = prevLevel;
    }
    ;
  }
  
}
