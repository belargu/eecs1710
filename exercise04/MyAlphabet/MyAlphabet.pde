/**
Date: 10-27-2021

Description:
an alphabet made of PShapes.
made letters up to p

Reference:
based off SelectionExample01.pde by Nick Fox Gieg
*/

LetterGenerator currentLetter;

void setup() {
  size(300,300,P2D);
  currentLetter = new LetterGenerator('a');
  
}

void draw() {
  background(0);
  currentLetter.draw();
}

void keyPressed() {
  currentLetter = new LetterGenerator(key);
}
