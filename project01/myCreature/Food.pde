class Food {
  PVector pos;
  PImage photo;
  String[] foodNames = {"bananaslug.png","burger.png","chicken.png","froglegs.png",
  "hotdog.png","lollipop.png","meatball.png","persimmon.png","shrimp.png",
  "steak.png"};
  
  Food(float tempX, float tempY) {
    pos = new PVector(tempX,tempY);
    imageMode(CENTER);
    photo = loadImage(foodNames[int(random(foodNames.length))]);
  }
  
  void draw() {
    image(photo,pos.x,pos.y);
  }
  
}
