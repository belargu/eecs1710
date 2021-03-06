/**
 contains subclasses of GameLevel, & their respective parameters
 */

class Level1 extends GameLevel {

  Level1() {
    levelNum = 0;
    folder = "suburb\\";
    levelLength = 15;
    load();
  }
}

/*------------------------------------------------------------*/

class Level2 extends GameLevel {

  Level2() {
    levelNum = 1;
    folder = "city\\";
    levelLength = 20;
    load();
  }
}

/*------------------------------------------------------------*/

class Level3 extends GameLevel {

  Level3() {
    levelNum = 2;
    folder = "forest\\";
    levelLength = 18;
    load();
    //move car forward a bit to give space to creature
    car = new Car(width/6, height*3/8);
    probability = 4;
  }
}
