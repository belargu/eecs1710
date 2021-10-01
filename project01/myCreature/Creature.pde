class Creature {
  PVector pos;
  PVector target;
  float vel;
  PImage limbs, body;
  
  //colors for now; final version should be img
  color alive = color(255,127,127);
  color deadColor = color(127);
  color creatureColor;
  
  //only 1 of these can be true at a time
  boolean dead = false;
  boolean escape = false;
  
  boolean isIdle = true;
  boolean isPet = false;
  boolean isEating = false;
  boolean isRunning = false;
  
  //constructor
  Creature() {
    pos = new PVector(width/2,height/2);
    newTarget();
    creatureColor = alive;
  }
  
  void draw() {
    fill(creatureColor);  
    ellipse(pos.x,pos.y,100,100);
    
    if (!dead && !escape) {
      if (isIdle) {
        idle();
      }
      
      //collision detection
      if (pos.x < marginLeft) {
        pos.x = marginLeft;
      }
      if (pos.x > marginRight) {
        pos.x = marginLeft;
      }
      if (pos.y < marginUp) {
        pos.y = marginUp;
      }
      if (pos.y > marginDown) {
        pos.y = marginDown;
      }
    
    } 
    
    else if (dead) {
      //draw dead gfx here
      creatureColor = deadColor;
    } 
    
    else if (escape) {
      //make it run away
      target = findNearestEdge();
      pos.lerp(target,.05);
      ;
    }
  }
  
  void idle() {
    pos.lerp(target,0.025);
    if (pos.dist(target) < 0.1) {
      newTarget();
    }
  }
  
  
  void newTarget() {
    target = new PVector(random(pos.x-50,pos.x+50),random(pos.y-50,pos.y+50));
  }
  
  PVector findNearestEdge() {
    PVector[] targetList = {new PVector(-200,pos.y),new PVector(1160,pos.y),
    new PVector(pos.x,-200), new PVector(pos.x,920)};
    
    //loop to find smallest distance
    PVector min = targetList[0];
    for (int i=0; i<targetList.length;i++) {
      if (pos.dist(targetList[i]) < pos.dist(min)) {
        min = targetList[i];
      }
    }
    return min;
  }
    
    
  
}
