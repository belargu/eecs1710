/**
contains parameters for each level
 */

class Level1 extends GameLevel {

  Level1() {
    levelNum = 0;
    folder = "suburb\\";
    levelLength = 15;
    load();
  }
}

class Level2 extends GameLevel {

  Level2() {
    levelNum = 1;
    folder = "city\\";
    levelLength = 20;
    load();
  }
}

class Level3 extends GameLevel {

  Level3() {
    levelNum = 2;
    folder = "forest\\";
    levelLength = 20;
    load();
  }
}
   
