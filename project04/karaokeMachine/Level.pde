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
  Button[] btnList = {new Button("start", 20, height*3/4), 
    new Button("callibrate", 20, height*7/8)};
  Start() {
    bg = loadImage("start.png");
  }

  void draw() {
    image(bg, 0, 0);

    for (Button b : btnList) {
      b.draw();
    }
  }
}

/*------------------------------------------------------------*/

class SongSelect extends Level {
  Button[] btnList = {new Button("exit", 10, 10), 
    new Button("sing!", 480, 10)};
  //arraylist so that songs can be easily added
  ArrayList<SongButton> songBtnList = new ArrayList<SongButton>();

  SongSelect() {
    bg = loadImage("select.png");

    //reset
    currentScroll = 0;

    int tempY = 70;
    //create btn list
    for (int i=0; i<songList.length; i++) {
      songBtnList.add(new SongButton(songList[i].fileName, i, 175, tempY));

      tempY += 50;
    }
  }

  void draw() {
    image(bg, 0, 0);

    for (Button b : btnList) {
      b.draw();
    } 

    for (int i=0; i<songBtnList.size(); i++) {
      songBtnList.get(i).pos.y = currentScroll+70+(i*50);
      songBtnList.get(i).draw();
    }

    strokeWeight(2);
    //name box
    stroke(YELLOW);
    fill(YELLOW);
    rect(0, height*7/8, width/3, (height/8)-1);
    textAlign(CENTER);
    textSize(30);
    fill(BLACK);
    text("current song:", width/6, height-22);

    //display song chosen
    stroke(YELLOW);
    fill(BLACK);
    rect(width/3, height*7/8, width*2/3, (height/8)-1);
    textAlign(CENTER);
    textSize(30);
    fill(YELLOW);
    text(currentSong.fileName, width*2/3, height-22);

    //header
    stroke(YELLOW);
    fill(BLACK);
    rect(170, -1, 300, 65);
    textAlign(CENTER);
    textSize(48);
    fill(YELLOW);
    text("SONGS", width/2, 45);
  }
}
/*------------------------------------------------------------*/

class Callibrate extends Level {
  Button[] btnList = {new Button("exit", 10, 10)};
  ArrayList<Line> voiceLines;
  float scrollSpeed = 5;
  float noteFreq, voiceHeight, voiceNote; 
  SliderButton slider;

  Callibrate() {
    bg = loadImage("callibrate.png");
    voiceLines = new ArrayList<Line>();
    int tempX = int(map(threshold,0,0.1,205,605));
    
    slider = new SliderButton(tempX,29);
  }

  void draw() {
    image(bg, 0, 0);

    //voice lines
    stroke(YELLOW);
    strokeWeight(5);
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

    //voice detection
    if (amp > threshold && freq > 0) { //only run code when loud enough
      voiceNote = 12*(log(freq/220)/log(2))+57;
      voiceHeight = map(voiceNote, 36, 95, height-60, 65);
      voiceLines.add(new Line(width, voiceHeight, 3));
    }

    for (Button b : btnList) {
      b.draw();
    }
    
    //slider
    strokeWeight(2);
    stroke(YELLOW);
    fill(YELLOW);
    rect(170,1,469,55);
    stroke(BLACK);
    fill(YELLOW);
    rect(172,3,465,51);
    strokeWeight(4);
    line(205,29,605,29);
    slider.draw();
    

    //instructions
    strokeWeight(2);
    stroke(YELLOW);
    fill(BLACK);
    rect(1, height-46, width-2, 45);
    textAlign(CENTER);
    textSize(24);
    fill(YELLOW);
    text("adjust to reduce the amount of noise picked up by your mic.", 
      width/2, height-18);
  }
}

/*------------------------------------------------------------*/

class Game extends Level {
  Meter meter = new Meter();
  ArrayList<Line> midiLines, voiceLines, instrLines;
  float scrollSpeed = 5; //64 frames; ~1.0667 seconds to get to middle
  // or 1067 milliseconds
  int noteHeight, currentNote, greenVal;
  float noteFreq, voiceHeight, voiceNote, closeness; 
  int prevNote = 0;

  //time stuff
  int startMillis, currentMillis, prevMillis;

  Game() {
    score = 0; //reset score
    midiPlayer.load(dataPath(currentSong.fileName));
    midiPlayer.start();

    midiLines = new ArrayList<Line>();
    voiceLines = new ArrayList<Line>();
    instrLines = new ArrayList<Line>();

    startMillis = millis();
  }

  void draw() {
    currentMillis = millis();

    strokeWeight(0);
    stroke(0);
    fill(0);
    rect(0, 0, width, height); //refresh screen 

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
    greenVal = int(map(closeness, 3, 0.1, 0, 255));
    stroke(255, greenVal, 0);
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

    //look at all midi notes
    for (Note n : midiPlayer.getNotes()) {      
      if (n.channel == currentSong.voiceChannel-1 && n.on) { //midiLines
        if (n.note != prevNote) {
          currentNote = n.note;
          //noteFreq = pow(440*2,((currentNote-69)/12));
          //println("current note: " + currentNote + ", freq: " + noteFreq);
        }
        noteHeight = int(map(n.note, 36, 95, height-60, 65)); //C2-B6

        midiLines.add(new Line(width, noteHeight, 3));
        prevNote = n.note;
      } else if (n.channel != currentSong.voiceChannel-1 && n.on) { //instrLines
        noteHeight = int(map(n.note, 24, 108, height-60, 65));

        instrLines.add(new Line(width, noteHeight, 1));
      }
    }
    
    //voice detection
    if (amp > threshold && freq > 0) { //only run code when loud enough
      voiceNote = 12*(log(freq/220)/log(2))+57;
      voiceHeight = map(voiceNote, 36, 95, height-60, 65);
      closeness = abs(currentNote - voiceNote);
      //println(closeness);

      voiceLines.add(new Line(width, voiceHeight, 3));
    }
  
    //add to score if voice is close enough to midi note
    if (closeness <= 3) {
      score += int(3-closeness);
    }
    
    //score
    textAlign(CENTER);
    textSize(48);
    fill(YELLOW);
    text(score, width/2, 50);

    //meter
    meter.draw();
    meter.fullness = map(currentMillis-startMillis, 0, currentSong.duration*1000,
    0, width-2);

    //go to GameOver when song is over
    if (meter.fullness >= width-2) {
      currentLevel = new GameOver();
    }

    midiPlayer.update();
  }
}

/*------------------------------------------------------------*/

class GameOver extends Level {
  Button[] btnList = {new Button("retry", 10, 10), 
    new Button("new song", 480, 10)};
  GameOver() {
    bg = loadImage("gameover.png");
  }

  void draw() {
    image(bg, 0, 0);

    //words
    textAlign(CENTER);
    fill(YELLOW);
    textFont(times);
    textSize(48);
    text("WOW! your score for", width/2, 160);
    textFont(comic);
    textSize(30);
    text(currentSong.fileName, width/2, 220);
    textFont(times);
    textSize(48);
    text("was", width/2, 280);
    textSize(60);
    text(score, width/2, height*3/4);

    for (Button b : btnList) {
      b.draw();
    }
  }
}
