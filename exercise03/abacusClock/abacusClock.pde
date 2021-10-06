/**
Date: 10-06-2021
Description:
  an abacus that counts time
  
Reference:
  - Prof. Fox Gieg's Clock02.pde
  -
    
*/
Abacus abacus;

int lastSecond = 0;

//toggle bg color; just for fun
  color[] bgColor = {color(32,0,0),color(127,127,203)};
  int currentColor = 0;

void setup() {
  size(962,583,P2D);
  abacus = new Abacus();
  
  //init with clock started accurately
  int s = second();
  int m = minute();
  int h = hour();
  
  int toBeMoved = abacus.rowLengths[0]-s%10;
  
  for (int i=0; i<5; i++) {
    for (int j=0; j<toBeMoved; j++) {
      abacus.moveRow(i,j);
    }
    //switch case to change toBeMoved, since each row uses diff time unit
    switch(i) {
      case 0:
        toBeMoved = (s-s%10)/10;
        break;
      case 1:
        toBeMoved = m%10;
        break;
      case 2:
        toBeMoved = (m-m%10)/10;
        break;
      case 3:
        if (h >= 12) h-=12;
        toBeMoved = h;
        break;
      case 4:
        break;
      default:
        break;
    }
    
  } 
}

void draw() {
  int s = second();
  int m = minute();
  int h = hour();
  
  //update clock
  if (s != lastSecond) {
    //for loop to reset any rows
    for (int i=0; i<5; i++) {
      if (abacus.beadList[i][0].x >= 791-47*(abacus.rowLengths[i])) {
        abacus.resetRow(i);
        
        //since rows all use diff units of time, use switch case
        switch(i) {
          case 0: //1st row resetted, update 2nd row
            abacus.moveRow(i+1,(s-s%10)/10);
            break;
          case 1: //2nd row, update 3rd
            abacus.moveRow(i+1,m%10);
            break;
          case 2: //3rd, update 4th
            abacus.moveRow(i+1,(m-m%10)/10);
            break;
          case 3: //4th, update 5th
            //convert any # after 12 to 0-11 since there's only 12 hr beads
            //if shortcut since it's so short
            if (h >= 12) h-=12;
            abacus.moveRow(i+1,h);
            break;
          case 4: //5th, pass
            break;
          default: //just in case
            break;
        }  
      }
    }


    abacus.moveRow(0,s%10);
    lastSecond = s;
    
    
  }
  
  background(bgColor[currentColor]);
  abacus.draw();
  ;
}

//toggle bg color w click
void mousePressed() {
  if (currentColor == 0){
    currentColor = 1;
  } else {
    currentColor = 0;
  }
}
