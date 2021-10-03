/**
Date: 10-01-2021
Description:
  making creature run away from mouse depending on trust
  adding more photos
  
Reference:
  - Prof. Fox Gieg's Creature01.pde, Creature02.pde
  - processing.org/reference
  - for nearestEdge(): 
    https://www.javatpoint.com/java-program-to-print-the-smallest-element-in-an-array
  - for getNearestFood():
    https://www.geeksforgeeks.org/finding-the-minimum-or-maximum-value-in-java-
    arraylist/
    
*/

//creating vars
Creature creature;
Subtitle subtitle;
color yellow = color(255,255,0);
PFont times;
PImage bg;
float marginUp, marginDown, marginLeft, marginRight;
ArrayList<Food> foodList = new ArrayList<Food>();
int nearestFood = 0;

//meters
Meter health = new Meter("HEALTH",10,10, color(255,0,0),1);
Meter trust = new Meter("TRUST",875,10, color(0,0,255),0.5);

void setup() {
  size(960,720,P2D);
  bg = loadImage("grass.png");
  times = createFont("Times New Roman",72);
  
  creature = new Creature();
  subtitle = new Subtitle();

  //create margins
  marginUp = 5;
  marginDown = height-5;
  marginLeft = 80;
  marginRight = width-80;
  
  ellipseMode(CENTER);
  imageMode(CENTER);
}

void draw() {
  background(bg);
 
  //loop to draw food
  for (Food food : foodList) {
    food.draw();
  }
 
  creature.draw();
    
  //ui
  health.draw();
  trust.draw();
  subtitle.draw();


  //creature conditionals
  if (health.value > .74) {
    creature.targetDist = 100;
  } else if (health.value > .24) {
    creature.targetDist = 50;
  } else if (health.value > 0) {
    creature.targetDist = 15;
  }
  
  if (health.value <= 0) {
    creature.state = "dead";
    subtitle.currentLine = subtitle.deadLine;
  }
  
  if (trust.value <= 0)  {
    creature.state = "escaping";
    subtitle.currentLine = subtitle.escapedLine;
  }
  
  if (foodList.size() > 0) {
    nearestFood = getNearestFood();
    creature.aliveState = "eating";
    if (creature.pos.dist(foodList.get(nearestFood).pos) < 1) {
      health.value+=0.02;
      foodList.remove(nearestFood);
    }
  }
}

/*-----------FUNCTIONS-----------*/

void mousePressed() {
  if (mouseButton == LEFT) {
    //hitting
    if (creature.state == "alive" && mouseX>creature.pos.x-50 && 
    mouseX<creature.pos.x+50 && mouseY>creature.pos.y-50 && 
    mouseY<creature.pos.y+50) {
      health.value-=0.025;
      trust.value-=0.0375;
      subtitle.currentLine = subtitle.hitLines
      [int(random(subtitle.hitLines.length))];
      print("hit\n");
    }
    //scaring
    else if (creature.state == "alive") {
      creature.aliveState = "scared";
      creature.run();
      trust.value-=0.025;
      subtitle.currentLine = subtitle.scareLines
      [int(random(subtitle.scareLines.length))];
      print("scare\n");
    }
  } 
  else if (mouseButton == RIGHT) {
    //petting
    if (creature.state == "alive" && mouseX>creature.pos.x-50 &&
    mouseX<creature.pos.x+50 && mouseY>creature.pos.y-50 && 
    mouseY<creature.pos.y+50) {
      trust.value+=0.01;
      subtitle.currentLine = subtitle.petLines
      [int(random(subtitle.petLines.length))];
      print("pet\n");
    }
    //placing food
    else if (mouseX > marginLeft && mouseX < marginRight && 
    mouseY > marginUp && mouseY < marginDown){
      foodList.add(new Food(mouseX,mouseY));
      subtitle.currentLine = subtitle.foodLine+
      foodList.get(foodList.size()-1).name.
      substring(0,foodList.get(foodList.size()-1).name.length()-4);
      print("food\n");
    }
  } 
}

//find food nearest to creature
int getNearestFood() {
  //find nearest vector
  PVector min = foodList.get(0).pos;
  for (int i=0; i<foodList.size();i++) {
    if (creature.pos.dist(foodList.get(i).pos) < creature.pos.dist(min)) {
        min = foodList.get(i).pos;
    }
  }
  
  //compare min with foodList again to find index of closest food
  //there has to be a more efficient way of doing this but i don't have enough time
  //sorry :(
  int foodIndex = 0;
  for (int i=0; i<foodList.size();i++) {
    if (min == foodList.get(i).pos) {
      foodIndex = i;
    }
  }
  return foodIndex;
}
