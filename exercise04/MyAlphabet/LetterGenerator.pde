class LetterGenerator {
  color[] colorList = {color(255,0,0),color(255,255,0),color(0,255,0),
color(0,255,255),color(0,0,255), color(255,0,255), color(255)};
  
  PVector pos = new PVector(50,50);
  PShape letter;
  
  LetterGenerator(char input) {
    letter = createShape();
    
    fill(colorList[int(random(colorList.length))]);
    
    switch (input) {
    case 'a':
      print("a\n");
      letter.beginShape();
      letter.vertex(100,0);
      letter.vertex(200,200);
      letter.bezierVertex(150,150,50,150,0,200);
      letter.endShape(CLOSE);
      
      break;
    case 'b':
      print("b\n");
      letter.beginShape();
      letter.vertex(0,0);
      letter.vertex(100,0);
      letter.bezierVertex(200,0,200,100,100,100);
      letter.bezierVertex(200,100,200,200,100,200);
      letter.vertex(0,200);
      letter.endShape(CLOSE);
      break;
    case 'c':
      print("c\n");
      letter.beginShape();
      letter.vertex(0,0);
      letter.vertex(200,0);
      letter.bezierVertex(0,0,0,200,200,200);
      letter.vertex(0,200);
      letter.endShape(CLOSE);
      break;
    case 'd':
      letter.beginShape();
      letter.vertex(0,0);
      letter.bezierVertex(200,0,200,200,0,200);
      letter.endShape(CLOSE);
      break;
    case 'e':
      letter.beginShape();
      letter.vertex(0,0);
      letter.vertex(200,0);
      letter.bezierVertex(0,0,0,100,200,100);
      letter.bezierVertex(0,100,0,200,200,200);
      letter.vertex(0,200);
      letter.endShape(CLOSE);
      break;
    case 'f':
      letter.beginShape();
      letter.beginShape();
      letter.vertex(0,0);
      letter.vertex(200,0);
      letter.bezierVertex(0,0,0,100,200,100);
      letter.bezierVertex(0,100,0,200,0,200);
      letter.endShape(CLOSE);
      break;
    case 'g':
      letter.beginShape();
      letter.vertex(200,0);
      letter.bezierVertex(0,0,0,200,200,200);
      letter.vertex(200,100);
      letter.bezierVertex(100,100,100,0,200,0);
      letter.endShape(CLOSE);
      break;
    case 'h':
      letter.beginShape();
      letter.vertex(0,0);
      letter.bezierVertex(0,100,200,100,200,0);
      letter.vertex(200,200);
      letter.bezierVertex(200,100,0,100,0,200);
      letter.endShape(CLOSE);
      break;
    case 'i':
      letter.beginShape();
      letter.vertex(0,0);
      letter.vertex(200,0);
      letter.bezierVertex(100,0,100,200,200,200);
      letter.vertex(0,200);
      letter.bezierVertex(100,200,100,0,0,0);
      letter.endShape(CLOSE);
      break;
    case 'j':
      letter.beginShape();
      letter.vertex(100,0);
      letter.vertex(200,0);
      letter.bezierVertex(200,200,0,200,0,0);
      letter.bezierVertex(0,100,100,100,100,0);
      letter.endShape(CLOSE);
      break;
    case 'k':
      letter.beginShape();
      letter.vertex(0,0);
      letter.bezierVertex(0,100,200,100,200,0);
      letter.bezierVertex(100,0,100,200,200,200);
      letter.bezierVertex(200,100,0,100,0,200);
      letter.endShape(CLOSE);
      break;
    case 'l':
      letter.beginShape();
      letter.vertex(0,0);
      letter.bezierVertex(0,100,100,200,200,200);
      letter.vertex(0,200);
      letter.endShape(CLOSE);
      break;
    case 'm':
      letter.beginShape();
      letter.vertex(0,0);
      letter.vertex(0,200);
      letter.bezierVertex(0,0,100,0,100,200);
      letter.bezierVertex(100,0,200,0,200,200);
      letter.vertex(200,0);
      letter.endShape(CLOSE);
      break;
    case 'n':
      letter.beginShape();
      letter.vertex(0,0);
      letter.vertex(0,200);
      letter.bezierVertex(0,0,200,0,200,200);
      letter.vertex(200,0);
      letter.endShape(CLOSE);
      break;
    case 'o':
      letter.beginShape();
      letter.vertex(100,0);
      letter.bezierVertex(150,0,200,50,200,100);
      letter.bezierVertex(200,150,150,200,100,200);
      letter.bezierVertex(50,200,0,150,0,100);
      letter.bezierVertex(0,50,50,0,100,0);
      letter.endShape(CLOSE);
      break;
    case 'p':
      letter.beginShape();
      letter.vertex(0,0);
      letter.bezierVertex(200,0,200,100,100,100);
      letter.bezierVertex(50,100,0,150,0,200);
      letter.endShape(CLOSE);
      break;
    case 'q':
      letter.beginShape();
      letter.vertex(100,0);
      letter.bezierVertex(150,0,200,50,200,100);
      letter.vertex(200,200);
      letter.vertex(100,200);
      letter.bezierVertex(50,200,0,150,0,100);
      letter.bezierVertex(0,50,50,0,100,0);
      letter.endShape(CLOSE);
      break;
    case 'r':
      letter.beginShape();
      
      letter.endShape(CLOSE);
      break;
    case 's':
      letter.beginShape();
      
      letter.endShape(CLOSE);
      break;
    case 't':
      letter.beginShape();
      
      letter.endShape(CLOSE);
      break;
    case 'u':
      letter.beginShape();
      
      letter.endShape(CLOSE);
      break;
    case 'v':
      letter.beginShape();
      
      letter.endShape(CLOSE);
      break;
    case 'w':
      letter.beginShape();
      
      letter.endShape(CLOSE);
      break;
    case 'x':
      letter.beginShape();
      
      letter.endShape(CLOSE);
      break;
    case 'y':
      letter.beginShape();
      
      letter.endShape(CLOSE);
      break;
    case 'z':
      letter.beginShape();
      
      letter.endShape(CLOSE);
      break;
    }
  }
  
  void draw() {
    shape(letter,pos.x,pos.y);
  }

}
