class Car {
  PVector pos;
  float vel = 0;
  float acc = 0;
  PImage img;
  
  Wheel[] wheels = new Wheel[2];
  
  ;
  
  Car(float tempX, float tempY) {
    pos = new PVector(tempX,tempY);
    img = loadImage("car.png");
    
    //create wheels 
    int temp = 28;
    for (int i=0;i<2;i++) {
      wheels[i] = new Wheel(pos.x+temp+36,pos.y+168+36);
      temp+= 185;
    }
  }
  
  
  void draw() {
    fill(203,21,0);
    imageMode(CORNER);
    image(img,pos.x,pos.y);
    
    for (Wheel i : wheels) {
      i.draw();
    }
  }
  
  void accelerate() {
    //controls
    if (keyPressed && key == ' ') {
      acc+= 0.25;
      print(acc+"\n");
    } else {
      acc-= 0.1875;
      print(acc+"\n");
    }
    if (acc < 0) {
      acc = 0;
      print(acc+"\n");
    }
    
    vel+=acc;
    for (Wheel i : wheels) {
      i.vel+=acc;
    }
    ;
  }
}
