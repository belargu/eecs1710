class Obstacle {
  PVector pos, rectPos, rectDimensions;
  PImage img;
  float vel;
  String folder = "obstacle\\";

  //2 lists since variable types can't mix
  //diff name & vel choices depending on level
  //i couldve made a class but didn't feel like it since it was just 2 variables
  String[][] nameList = {{"old", "boy"}, {"man", "woman"}, {"log", "fox"}};
  float[][] velList = {{0.25, 1.175}, {0.5, 0.75}, {1, 0.75}}; 

  Obstacle(int levelNum) {
    //create random int to pick random name & corresponding vel
    int rand = int(random(nameList[levelNum].length));
    img = loadImage(folder + nameList[levelNum][rand] +".png");
    vel = velList[levelNum][rand];

    pos = new PVector(random(width, width*2), random(height/2-img.height, (height*3/4)-img.height));
    //hitbox coords
    rectPos = new PVector(pos.x,pos.y+img.height*7/8);
    rectDimensions = new PVector(img.width,img.height/8);
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
