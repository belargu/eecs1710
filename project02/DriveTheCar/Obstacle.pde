class Obstacle {
  PVector pos, rectPos, rectDimensions;
  PImage img;
  float vel;
  String folder = "obstacle\\";

  //2 lists since variable types can't mix
  //diff name & vel choices depending on level
  String[][] nameList = {{"old", "boy"}, {"man", "woman"}, {"log", "fox"}};
  float[][] velList = {{0.25, 1}, {0.75, 1}, {1, 1}}; 

  Obstacle(int levelNum) {
    //create random int to pick random name & corresponding vel
    int rand = int(random(2));
    img = loadImage(folder + nameList[levelNum][rand] +".png");
    vel = velList[levelNum][rand];

    pos = new PVector(random(width, width*2), random(320-img.height, 360-img.height));
    //hitbox coords
    rectPos = new PVector(pos.x+img.width/4,pos.y+img.height*7/8);
    rectDimensions = new PVector(img.width/2,img.height/8);
  }

  void draw() {
    imageMode(CORNER);
    image(img, pos.x, pos.y);
    
    //rect hitbox representation
    //rect(rectPos.x,rectPos.y,rectDimensions.x,rectDimensions.y);
    
    //move diagonally
    pos.x-=vel;
    pos.y+=vel;
    rectPos.x-=vel;
    rectPos.y+=vel;
  }
}
