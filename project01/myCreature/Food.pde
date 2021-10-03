class Food {
  PVector pos;
  PImage photo;
  String[] foodNames = {"bacon.png", "bananaslug.png", "burger.png", "chicken.png", 
    "chocolate.png", "corn.png", "froglegs.png", "hotdog.png", "lollipop.png", 
    "meatball.png", "persimmon.png", "pizza.png", "shrimp.png", "steak.png"};
  String name;

  Food(float tempX, float tempY) {
    pos = new PVector(tempX, tempY);
    imageMode(CENTER);
    name = foodNames[int(random(foodNames.length))];
    photo = loadImage(name);
  }

  void draw() {
    image(photo, pos.x, pos.y);
  }
}
