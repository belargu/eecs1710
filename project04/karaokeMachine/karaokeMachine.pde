/**
Date: 12-10-2021
Description:
a program that uses minim & midi to replicate a karaoke machine.

References:
some code (ie meter & levels) taken from project02
midi player
https://github.com/hamoid/Fun-Programming/tree/master/processing/ideas/2017/
04/MidiViz

midi/hz conversion
https://www.music.mcgill.ca/~gary/307/week1/node28.html



*/
import java.util.Collection;
import javax.sound.midi.*;
import processing.sound.*;

AMidiPlayer midiPlayer;

//colors
color RED = color(255,0,0);
color YELLOW = color(255,255,0);
color GREEN = color(0,255,0);
color CYAN = color(0,255,255);
color BLUE = color(0,0,255);
color MAGENTA = color(255,0,255);
color BLACK = color(0);
color WHITE = color(255);
color[] colorList = {RED, YELLOW, GREEN, CYAN, BLUE, MAGENTA};

PFont times;

Level currentLevel;
Song currentSong;
Song[] songList = {new Song("rayoflight.mid",3,319),
new Song("lovecomesquickly.mid",0,252),new Song("everybodyhurts.mid",3,302),
new Song("chainsoflove.mid",2,235), new Song("roxanne.mid",3,196)};
int score;

//scroll for SongSelect
int currentScroll = 0;

void setup() {
  size(640,480,P2D);
  background(0);
  times = createFont("Times New Roman", 200);
  textFont(times);
  
  midiPlayer = new AMidiPlayer();
  //midiPlayer.load(dataPath("rayoflight2.mid"));
  //midiPlayer.start();
  
  currentLevel = new Start();
  currentSong = songList[3];

}

void draw() {
  strokeWeight(0);
  stroke(0);
  fill(0);
  rect(0,0,width,height); //refresh screen
  
  currentLevel.draw();
}

void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  currentScroll += e*10;
  if (currentScroll > 0) {
      currentScroll = 0;
    }
}
