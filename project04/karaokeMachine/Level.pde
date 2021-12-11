/**
level superclass & subclasses such as StartScene, SongSelect, Callibrate,
Game, & GameOver
*/

class Level {
  PImage bg;
  Button[] btnList;

  void draw() {
    ;
  }
}

/*------------------------------------------------------------*/

class Start extends Level {
    Button[] btnList = {new Button("start",20,height*3/4),
    new Button("callibrate",20,height*7/8)};
  Start() {
    bg = loadImage("start.png");
  }
  
  void draw() {
    image(bg,0,0);
    
    for (Button b : btnList) {
      b.draw();
      
    }
  }  
}

/*------------------------------------------------------------*/

class SongSelect extends Level {
    Button[] btnList = {new Button("exit",10,10),
    new Button("sing!",480,10)};
    //arraylist so that songs can be easily added
    ArrayList<SongButton> songBtnList = new ArrayList<SongButton>();
    
  SongSelect() {
    //midiPlayer.stop();
    bg = loadImage("select.png");
    
    //reset
    currentScroll = 0;
    
    int tempY = 70;
    //create btn list
    for (int i=0;i<songList.length;i++) {
      songBtnList.add(new SongButton(songList[i].fileName,i,175,tempY));
      
      tempY += 50;
    }
  }
  
  void draw() {
    image(bg,0,0);
    
    for (Button b : btnList) {
      b.draw(); 
    } 

    for (int i=0;i<songBtnList.size();i++) {
      songBtnList.get(i).pos.y = currentScroll+70+(i*50);
      songBtnList.get(i).draw();
    }
    
    strokeWeight(2);
    //name box
    stroke(YELLOW);
    fill(YELLOW);
    rect(0,height*7/8,width/3,(height/8)-1);
    textAlign(CENTER);
    textSize(30);
    fill(BLACK);
    text("current song:",width/6,height-22);
    
    //display song chosen
    stroke(YELLOW);
    fill(BLACK);
    rect(width/3,height*7/8,width*2/3,(height/8)-1);
    textAlign(CENTER);
    textSize(30);
    fill(YELLOW);
    text(currentSong.fileName,width*2/3,height-22);
    
    //header
    stroke(YELLOW);
    fill(BLACK);
    rect(170,-1,300,65);
    textAlign(CENTER);
    textSize(48);
    fill(YELLOW);
    text("SONGS",width/2,45);
  }  

}
/*------------------------------------------------------------*/

class Callibrate extends Level {
    Button[] btnList = {new Button("exit",10,10)};
    
  Callibrate() {
    bg = loadImage("callibrate.png");
  }
  
  void draw() {
    image(bg,0,0);
    
    for (Button b : btnList) {
      b.draw();
      
      
    } 
  }  
}

/*------------------------------------------------------------*/

class Game extends Level {
    Meter meter = new Meter();
    ArrayList<Line> midiLines, voiceLines, instrLines;
    float scrollSpeed = 5;
    int noteHeight, prevNote, currentNote;
  
  Game() {
   midiPlayer.load(dataPath(currentSong.fileName));
   midiPlayer.start();
   
   midiLines = new ArrayList<Line>();
   voiceLines = new ArrayList<Line>();
   instrLines = new ArrayList<Line>();
  }
  
  void draw() {
    strokeWeight(0);
    stroke(0);
    fill(0);
    rect(0,0,width,height); //refresh screen 
    
    //instrumental lines; for aesthetic
    strokeWeight(5);
    stroke(BLUE);
    for (int i=instrLines.size()-1; i>=0; i--) {
      Line line = instrLines.get(i);
      if (line.x >= 0) {
        line(line.x, line.y1, line.x, line.y2);
        line.x -= scrollSpeed;
      } else {
        instrLines.remove(i);
        //println("line removed");
      }
    }
    
    //midi lines
    stroke(CYAN);
    for (int i=midiLines.size()-1; i>=0; i--) {
      Line line = midiLines.get(i);
      if (line.x >= 0) {
        line(line.x, line.y1, line.x, line.y2);
        line.x -= scrollSpeed;
      } else {
        midiLines.remove(i);
        //println("line removed");
      }
    }
    
    //voice lines
    int closeness = 0;
    stroke(255,closeness,0);
    for (int i=voiceLines.size()-1; i>=0; i--) {
      Line line = voiceLines.get(i);
      if (line.x >= 0) {
        line(line.x, line.y1, line.x, line.y2);
        line.x -= scrollSpeed;
      } else {
        voiceLines.remove(i);
        //println("line removed");
      }
    }
    
    for (Note n : midiPlayer.getNotes()) {      
      if (n.channel == currentSong.voiceChannel-1 && n.on) {
        if (n.note != prevNote) {
          currentNote = n.note;
          println("current note: " + currentNote);
        }
        noteHeight = int(map(n.note,36,95,height-60,65));
        
        midiLines.add(new Line(width,noteHeight,3));
        prevNote = n.note;
      } else if (n.channel != currentSong.voiceChannel-1 && n.on) {
        noteHeight = int(map(n.note,24,108,height-60,65));
        
        instrLines.add(new Line(width,noteHeight,1));
      }
      
    }
    
    //line
    stroke(WHITE);
    strokeWeight(1);
    line(width/2,65,width/2,height-60);
    
    //score
    textAlign(CENTER);
    textSize(48);
    fill(YELLOW);
    text(score,width/2,50);
    
    //meter
    meter.draw();
    
  }  
}

/*------------------------------------------------------------*/

class GameOver extends Level {
    Button[] btnList = {new Button("retry",10,10),
    new Button("new song",10,65)};
  GameOver() {
    bg = loadImage("gameover.png");
  }
  
  void draw() {
    image(bg,0,0);
    
    for (Button b : btnList) {
      b.draw();
      
      
    } 
  }  
}
