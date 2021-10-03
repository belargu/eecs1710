class Creature {
  PVector pos;
  PVector target;
  float targetDist = 100;

  float angle;
  float prevSpeed = 1;
  float rotateSpeed = 1;

  float prevVel = 0.025;
  float vel = 0.025;

  PImage limbs, body, dead, hearts;

  String state = "alive";
  String aliveState = "idle";

  //constructor
  Creature() {
    pos = new PVector(width/2, height/2);
    newTarget();
    //default speed; will slow if close to death
    limbs = loadImage("limbs.png");
    body = loadImage("body.png");
    dead = loadImage("dead.png");
    hearts = loadImage("hearts.gif");
  }

  void draw() {
    rectMode(CENTER);
    ellipseMode(CENTER);
    imageMode(CENTER);

    switch(state) {
        //when health is 0
      case "dead":
        //draw dead gfx here
        image(dead,pos.x,pos.y);
        break;
  
        //when trust is 0
      case "escaping":
        target = nearestEdge();
        pos.lerp(target, .05);
        break;
  
      case "alive":
        //cases within a case; stuff creature can only do when alive
        switch(aliveState) {
          case "idle":
            pos.lerp(target, vel);
            if (pos.dist(target) < 0.1) {
              newTarget();
              subtitle.currentLine = subtitle.idle;
              rotateSpeed = prevSpeed;
              vel = prevVel;
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
    
          case "scared":
            pos.lerp(target, vel);
            if (pos.dist(target) < 5) {
              aliveState = "idle";
              rotateSpeed = prevSpeed;
              vel = prevVel;
              break;
            }
            break;
    
          case "eating":
            //prevent out of bounds with this if statement
            if (nearestFood < foodList.size()) {
              pos.lerp(foodList.get(nearestFood).pos, .025);
              break;
            } else {
              //go back to idle when there's no more food
              subtitle.currentLine = subtitle.eatLines
              [int(random(subtitle.eatLines.length))];
              newTarget();
              aliveState = "idle";
              rotateSpeed = prevSpeed;
              vel = prevVel;
              
            }
            break;
        }
        break;
     }

    //actually draw the creature
    if (state != "dead") {
      drawLimbs();
      image(body, pos.x, pos.y); 
    }
  }

  //used for movement
  void newTarget() {
    target = new PVector(random(pos.x-targetDist, pos.x+targetDist), 
      random(pos.y-targetDist, pos.y+targetDist));
  }
  
  //rotating limbs
  void drawLimbs() {
    pushMatrix();
    translate(pos.x, pos.y);
    angle+=rotateSpeed;
    rotate(radians(angle));
    //idk why i had to divide coords by screen dimensions
    //but that's how it draws correctly
    image(limbs, pos.x/width, pos.y/height);
    popMatrix();
  }


  void run() {
    newTarget();
    prevVel = vel;
    prevSpeed = rotateSpeed;
    float[] directions = {-100, 100};
    target.x+=directions[int(random(2))];
    target.y+=directions[int(random(2))];
    rotateSpeed = 10;
    vel*=2;
  }


  //used to escape
  PVector nearestEdge() {
    PVector[] targetList = {new PVector(-200, pos.y), new PVector(1160, pos.y), 
      new PVector(pos.x, -200), new PVector(pos.x, 920)};

    //loop to find smallest distance
    PVector min = targetList[0];
    for (int i=0; i<targetList.length; i++) {
      if (pos.dist(targetList[i]) < pos.dist(min)) {
        min = targetList[i];
      }
    }
    //turn creature towards last target

    return min;
  }
}
