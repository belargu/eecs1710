/**
Date: 12-11-2021
Description:
a program that uses minim & midi to replicate a karaoke machine.
everything is pretty much done, i wish i had a better mic to pick up more
accurate frequencies
i couldn't figure out how to implement the delay so that the current note to sing/
the current note on screen happens in the middle... hope that's ok

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

PFont times, comic;

Level currentLevel;
Song currentSong;
Song[] songList = {new Song("rayoflight.mid",3,319),
new Song("lovecomesquickly.mid",0,252),new Song("everybodyhurts.mid",3,302),
new Song("chainsoflove.mid",2,235), new Song("roxanne.mid",3,196),
new Song("ymca.mid",3,236),new Song("comeundone.mid",0,219),
new Song("fantasy.mid",3,253),new Song("deaconblues.mid",8,474),
new Song("sos.mid",3,206),new Song("justcantgetenough.mid",4,185),
new Song("wildhoneypie.mid",1,55),new Song("just.mid",8,236),
new Song("kokomo.mid",1,228),};
int score;

//scroll for SongSelect
int currentScroll = 0;
float threshold = 0.005;

void setup() {
  size(640,480,P2D);
  background(0);
  times = createFont("Times New Roman", 200);
  comic = createFont("comicz.ttf",200);
  textFont(times);
  
  setupSound();
  midiPlayer = new AMidiPlayer();
  
  currentLevel = new Start();
  currentSong = songList[0]; //default

}

void draw() {
  updateSound();
  
  currentLevel.draw();
  
  /*
  if (amp > threshold) {
    println("volume: " + amp + " freq: " + freq);
  }*/
}

void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  currentScroll += -(e*10);
  if (currentScroll > 0) {
      currentScroll = 0;
    }
}
