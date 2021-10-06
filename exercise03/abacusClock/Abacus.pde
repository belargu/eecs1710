class Abacus {
  PImage image = loadImage("abacus.png");
  String[] colors = {"red.png","orange.png","yellow.png","green.png","blue.png"};
       
  float tempX = 125;
  float tempY = 116;

  //prepare jagged array to contain beads
  Bead[][] beadList = new Bead[5][];
  int[] rowLengths = {10,6,10,6,12};
  ;
  
  //constructor
  Abacus() {
    
    //create beads in array using for loop
    for (int i=0; i<5; i++) {
      beadList[i] = new Bead[rowLengths[i]];
      for (int j=0; j<rowLengths[i]; j++) { 
        beadList[i][j] = new Bead(i,tempX,tempY);
        tempX += 47;
      }
      tempY+=70;
      tempX = 125; //reset
    }
    
  } 
  
  void draw() {
    image(image,0,0);
    
    //draw beads
    for (int i=0; i<5; i++) {
      for (int j=0; j<rowLengths[i]; j++) {
        beadList[i][j].draw();
      }
    }
  }
  
  void moveRow(int row, int subtract) {
    //move bead to other side
    beadList[row][rowLengths[row]-1-subtract].x = 791 - 47*subtract;

    }
  
  void resetRow(int row) {
    //move beads in row back to normal
    float resetX = 125;
    for (int i=0; i<rowLengths[row]; i++) { 
        beadList[row][i].x = resetX;
        resetX += 47;
    }
  }
}
