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
  int levelLength;
  int probability = 2; //# for generating obstacles

  //change bg from PImage to MovingImage
  MovingImage road, nextRoad, bg, nextBg, mid, nextMid;
  PImage finishLine;

  String[] midgrounds = new String[4];
  ArrayList<Obstacle> obsList = new ArrayList<Obstacle>();

  Car car;
  Meter meter;
  Creature creature; //only to be used in Level3

  GameLevel() {
    car = new Car(width/12, height*3/8);
    meter = new Meter();
    creature = new Creature(-200, height/2);
    finishLine = loadImage("finishline.png");
  }

  void draw() {
    car.move();

    /** parallax bgs.
     all these if statements for image looping is clunky but it's because
     each layer has slightly different conditions
     (road layer generates obstacles, mid layer loads random imgs)
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
      //randomly generate obstacle
      if (int(random(probability)) == 1) {
        obsList.add(new Obstacle(levelNum));
      }
    }

    //finish line
    image(finishLine, (width*(levelLength))-car.dist*.5, 360);


    //unique things to draw for each level
    switch(levelNum) {
    case 0:
      if (200-car.dist*.5 > -200) {
        image(loadImage("creature\\dead.png"), 200-car.dist*.5, height/2);
      }
      break;
    case 2: //creature chase
      creature.pos.x-=car.vel*.5;
      creature.pos.x+=3.375;
      creature.draw();
      if (creature.pos.x > car.pos.x) {
        currentLevel = new GameOver(levelNum);
      } 
      //big text
      fill(yellow);
      textAlign(CENTER);
      textSize(150);
      text("RUN.", width/2+2, 110);
      break;
    }

    //car
    car.draw();

    //draw & move every obstacle in relation to car. also hit detection 
    for (Obstacle i : obsList) {
      //remove obstacle if no longer on screen
      if (i.pos.y > height*5/6 || i.pos.x+i.img.width < 0) {
        obsList.remove(i);
        break;
      }

      i.pos.x-=car.vel*.5;
      i.rectPos.x-=car.vel*.5;

      //draw obstacle behind car if above y 430
      if (i.pos.y+i.img.height < car.vertices[0].y) {
        i.draw();
        car.draw();
      } else if (i.pos.y+i.img.height >= car.vertices[0].y) {
        car.draw();
        i.draw();
      }
      
      //hit detection
      if (polyRect(car.vertices, i.rectPos.x, i.rectPos.y, i.rectDimensions.x, i.rectDimensions.y)) {
        currentLevel = new GameOver(levelNum);
      }
      
    }

    //go to next level
    if (meter.fullness >= width) {
      currentLevel = new NextLevel(levelNum);
    }

    //meter
    meter.draw();
    meter.fullness = map(car.dist*.5, 0, width*levelLength, 0, width);
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

  /*----------*/

  //CODE COPIED; SOURCE IN Reference
  // POLYGON/RECTANGLE
  boolean polyRect(PVector[] vertices, float rx, float ry, float rw, float rh) {

    // go through each of the vertices, plus the next
    // vertex in the list
    int next = 0;
    for (int current=0; current<vertices.length; current++) {

      // get next vertex in list
      // if we've hit the end, wrap around to 0
      next = current+1;
      if (next == vertices.length) next = 0;

      // get the PVectors at our current position
      // this makes our if statement a little cleaner
      PVector vc = vertices[current];    // c for "current"
      PVector vn = vertices[next];       // n for "next"

      // check against all four sides of the rectangle
      boolean collision = lineRect(vc.x, vc.y, vn.x, vn.y, rx, ry, rw, rh);
      if (collision) return true;
    }

    return false;
  }

  // LINE/RECTANGLE
  boolean lineRect(float x1, float y1, float x2, float y2, float rx, float ry, float rw, float rh) {

    // check if the line has hit any of the rectangle's sides
    // uses the Line/Line function below
    boolean left =   lineLine(x1, y1, x2, y2, rx, ry, rx, ry+rh);
    boolean right =  lineLine(x1, y1, x2, y2, rx+rw, ry, rx+rw, ry+rh);
    boolean top =    lineLine(x1, y1, x2, y2, rx, ry, rx+rw, ry);
    boolean bottom = lineLine(x1, y1, x2, y2, rx, ry+rh, rx+rw, ry+rh);

    // if ANY of the above are true,
    // the line has hit the rectangle
    if (left || right || top || bottom) {
      return true;
    }
    return false;
  }

  // LINE/LINE
  boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

    // calculate the direction of the lines
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      return true;
    }
    return false;
  }
}
