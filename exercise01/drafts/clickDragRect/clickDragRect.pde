/**
source:
https://forum.processing.org/one/topic/manipulating-shapes-drawn-in-canvas.html
*/

int lineToolX, lineToolY;
int oldWidth, oldHeight;
void setup() {
  size(400, 400);
  background(255);
  frameRate(200);
  loadPixels();
}
void draw()
{
  if (keyPressed) {
    // delete
    stroke(255);
    rect(lineToolX, lineToolY, oldWidth, oldHeight );
    // paint
    stroke (0);
    rect(lineToolX, lineToolY, mouseX-lineToolX, mouseY-lineToolY);
    oldWidth=mouseX-lineToolX;
    oldHeight=mouseY-lineToolY;
  }
  else {
    // not keyPressed
    if (mousePressed) {
      updatePixels();
      stroke(0);
      strokeWeight(3);
      noFill();
      rect(lineToolX, lineToolY, mouseX-lineToolX, mouseY-lineToolY);
      oldWidth=mouseX-lineToolX;
      oldHeight=mouseY-lineToolY;
    }
  }
}
void mousePressed()
{
  lineToolX = mouseX;
  lineToolY = mouseY;
}
void mouseReleased() {
  loadPixels();
}
