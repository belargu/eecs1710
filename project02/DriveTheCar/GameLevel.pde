class GameLevel extends Level {
  PImage[] bgList;
  Obstacle[] obsList;
  Car car;
  
  void hitObstacle() {
    //returns true/false, call fcn in level draw loop
    //then in level file, if hitObstacle == true, call lose(). pass the current level in parameters 
    ;
  }
  
  //
  void lose(GameLevel level) {
    currentLevel = new GameOver(level);
  }
  
}
