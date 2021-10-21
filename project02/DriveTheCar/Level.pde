/**
 contains Level superclass. Level's subclasses: StartScene, GameOver, TheEnd, GameLevel
 also contains GameLevel. GameLevel's subclasses: Level1, Level2, Level3
 i condensed these 2 classes together into 1 file since Level is so short
 */
class Level {
  PImage bg;

  void draw() {
    ;
  }
}

/*------------------------------------------------------------*/

class GameLevel extends Level {
  String folder;
  int levelNum;
  int levelLength, travelled;

  //change bg from PImage to MovingImage
  MovingImage road, nextRoad, bg, nextBg, mid, nextMid;

  String[] midgrounds = new String[4];
  Obstacle[] obstacles;

  Car car;
  Creature creature; //only to be used in Level3

  GameLevel() {
    car = new Car(width/6, height*3/8);
    creature = new Creature(-400,height/2);
  }

  void draw() {
    car.move();
    
    /** parallax bgs.
      all these if statements for image looping is clunky but it's because
      each layer has slightly different conditions
      (road layer counts travel length, mid layer loads random imgs)
    */
    imageMode(CORNER);
    //sky
    image(bg.img, bg.x, 0);
    image(nextBg.img, nextBg.x, 0);
    bg.x -= car.vel*.05;
    nextBg.x -= car.vel*.05;
    if (nextBg.x <=0) {
      bg.x = nextBg.x;
      nextBg.x+=width;
    }

    //midground
    image(mid.img, mid.x, 0);
    image(nextMid.img, nextMid.x, 0);
    mid.x -= car.vel*.3;
    nextMid.x -= car.vel*.3;
    if (nextMid.x <=0) {
      mid = nextMid;
      //without adding mid.x to x, there will be a gap
      //might be because it's loading while moving at the same time
      nextMid = new MovingImage(midgrounds[int(random(4))], width+mid.x);
    }

    //road
    image(road.img, road.x, 0);
    image(nextRoad.img, nextRoad.x, 0);
    road.x -= car.vel*.5;
    nextRoad.x -= car.vel*.5;
    if (nextRoad.x <=0) {
      road.x = nextRoad.x;
      nextRoad.x+=width;
      travelled++; 
    }
    
    //unique things to draw for each level
    switch(levelNum) {
      case 0:
        if (200-car.dist*.5 > -200) {
          image(loadImage("creature\\dead.png"),200-car.dist*.5,height/2);
        }
        break;
      case 2:
        //creature chase code here
        creature.pos.x-=car.vel*.5;
        creature.pos.x+=3;
        creature.draw();
        if (creature.pos.x > car.pos.x) {
          currentLevel = new GameOver(new Level3());
        } 
        //big text
        fill(yellow);
        textAlign(CENTER);
        textSize(150);
        text("RUN", width/2+2, 110);
            
        break;
    }

    //car
    car.draw();

    //go to next level
    if (travelled >= levelLength) {
      currentLevel = new NextLevel(levelNum);
    }

    //toolbar
    fill(0);
    rect(0, height*5/6, width, height);
  }

  boolean hitObstacle() {
    //returns true/false, call fcn in level draw loop
    //then in level file, if hitObstacle == true, call lose(). pass the current level in parameters 
    return false;
  }

  //
  void lose(GameLevel level) {
    currentLevel = new GameOver(level);
  }

  //to be called in level1-3 constructors since it needs folder first
  void load() {

    //nextRoad, nextBg, nextMid used for parallax
    road = new MovingImage((folder + "road.png"), 0);
    nextRoad = new MovingImage((folder + "road.png"), width);
    bg = new MovingImage((folder + "sky.png"), 0);
    nextBg = new MovingImage((folder + "sky.png"), width);

    for (int i=0; i<4; i++) {
      midgrounds[i] = folder + "midground" + str(i+1) + ".png";
    }
    mid = new MovingImage(midgrounds[int(random(4))], 0);
    nextMid = new MovingImage(midgrounds[int(random(4))], width);
    
  }
  
}
