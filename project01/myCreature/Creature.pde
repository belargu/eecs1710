class Creature {
  PVector pos;
  PVector target;
  float vel;
  PImage limbs, body;
  
  //colors for now; final version should be img
  color alive = color(255,127,127);
  color deadColor = color(127);
  color creatureColor;
  
  String state = "alive";
  String aliveState = "idle";

  //constructor
  Creature() {
    pos = new PVector(width/2,height/2);
    newTarget();
    creatureColor = alive;
    //default speed; will slow if close to death
    vel = 0.025;
  }
  
  void draw() {
    fill(creatureColor);  
    ellipse(pos.x,pos.y,100,100);
    
    switch(state) {
      //when health is 0
      case "dead":
        //draw dead gfx here
        creatureColor = deadColor;
        break;
        
      //when trust is 0
      case "escaping":
        target = nearestEdge();
        pos.lerp(target,.05);
        break;
        
      case "alive":
        //cases within a case; stuff creature can only do when alive
        switch(aliveState) {
          case "idle":
            pos.lerp(target,vel);
            if (pos.dist(target) < 0.1) {
              newTarget();
            }
            
            //collision
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
            break;
            
          case "running":
    
            break;
            
          case "eating":
            //prevent out of bounds with this if statement
            if (nearestFood < foodList.size()) {
              pos.lerp(foodList.get(nearestFood).pos,.025);
              break;
            } else {
              //go back to idle when there's no more food
              newTarget();
              aliveState = "idle";
            }
            break;
        }
        break;

    }
       
  }
  
  //used for movement
  void newTarget() {
    target = new PVector(random(pos.x-50,pos.x+50),random(pos.y-50,pos.y+50));
  }
  
  //used to escape
  PVector nearestEdge() {
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
