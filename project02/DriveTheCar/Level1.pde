class Level1 extends GameLevel {
  
  
  
  Level1() {
    car = new Car(width/8,height*3/8);
  }
  
  void draw() {
    car.accelerate();
    
    //sky
    fill(135,223,255);
    rect(0,0,width,height);
    
    //midground
    fill(203,197,127);
    rect(0-car.vel*.4,height/8,width,height/4);
    
    //grass
    fill(135,255,112);
    rect(0-car.vel*.5,height*3/8,width,height);
    
    //road
    fill(100);
    rect(0-car.vel*.5,height/2,width,height/4);
    
    //car
    car.draw();
    
    //toolbar
    fill(27);
    rect(0,height*5/6,width,height);
    
  }

}
