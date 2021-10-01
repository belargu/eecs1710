class Food {
  float x, y;
  PImage photo;
  String[] foodNames = {"bananaslug.png","burger.png","chicken.png","froglegs.png",
  "hotdog.png","lollipop.png","meatball.png","persimmon.png","shrimp.png",
  "steak.png"};
  boolean eaten = false;
  
  Food(float tempX, float tempY) {
    x = tempX;
    y = tempY;
    imageMode(CENTER);
    photo = loadImage(foodNames[int(random(foodNames.length))]);
  }
  
  void draw() {
    if (eaten == false) {
      image(photo,x,y);
    }
  }
  
  void eat() {
    eaten = true;
  }

}
