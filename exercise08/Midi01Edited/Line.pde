class Line {

  int radius = 5;
  float x, y1, y2;
  
  
  Line(float _x, float _y) {
    x = _x;
    y1 = _y - radius;
    y2 = _y + radius;
  }
  
  void draw() {
    ;
  }
  
}
