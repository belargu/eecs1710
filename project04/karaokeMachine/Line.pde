class Line {

  int thickness = 3;
  float x, y1, y2;
  
  
  Line(float _x, float _y, int tempThick) {
    thickness = tempThick;
    x = _x;
    y1 = _y - thickness;
    y2 = _y + thickness;
  }
  
  void draw() {
    ;
  }
  
}
