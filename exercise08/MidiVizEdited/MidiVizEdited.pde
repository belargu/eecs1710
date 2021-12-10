import java.util.Collection;
import javax.sound.midi.*;

AMidiPlayer midiPlayer;
PShader shader;

int noteHeight, prevNote, currentNote;

ArrayList<Line> lines;
float scrollSpeed = 5;


void setup() {
  size(640,480,P2D);
  //fullScreen(P3D);
  background(0);
  //colorMode(HSB);
  //noStroke();
  midiPlayer = new AMidiPlayer();
  midiPlayer.load(dataPath("rayoflight2.mid"));
  midiPlayer.start();
  //shader = loadShader("shader.glsl");
  
  lines = new ArrayList<Line>();
}

void draw() {
  /**
  //background(#112244);
  shader.set("n", 20 * noise(frameCount * 0.001));

  translate(width/2, height/2);
  rotateZ(noise(0.23, 15 * frameCount * 0.00013));
  rotateY(frameCount * 0.003);

  directionalLight(30, 20, 255, 1, 1, 1);
  directionalLight(150, 20, 255, -1, -1, -1);
  
  for (Note n : midiPlayer.getNotes()) {
    fill(map(n.note % 12, 0, 11, 0, 255), 
      map(n.channel, 0, 15, 80, 255), 
      map(n.note, 0, 127, 100, 255) * random(0.9, 1.0));

    pushMatrix();
    float t = frameCount * 0.003;
    scale(n.velocity * 0.05);
    rotateX(n.channel + noise(n.note * 0.1, t));
    rotateY(n.note * 0.06);
    rotateZ(map(n.note % 12, 0, 12, 0, TWO_PI));
    pushMatrix();
    translate(0, n.velocity * 0.7, 0);
    box(40.0 / n.living, n.velocity * 0.1 + random(10), 40.0 / n.living);
    popMatrix();    
    translate(0, 5000.0, 0);
    box(0.2, 10000, 0.2);
    popMatrix();
  }
  */
  strokeWeight(0);
  stroke(0);
  fill(0);
  rect(0,0,width,height); //refresh screen
  
  strokeWeight(5);
  stroke(255, 255, 0);
  for (int i=lines.size()-1; i>=0; i--) {
    Line line = lines.get(i);
    if (line.x >= 0) {
      line(line.x, line.y1, line.x, line.y2);
      line.x -= scrollSpeed;
    } else {
      lines.remove(i);
      //println("line removed");
    }
  }
  
  /**
  CURRENT PROBLEM:
  can't figure out why line keeps drawing even after note stops playing
  or like... i know why but idk how to detect when it turns off
  
  when n.dying == 10 it ONLY draws after note stops... interesting
  
  CONSIDER ShortMessage.NOTE_ON
  
  UPDATE I FIGURED IT OUT... it was bc i wasn't drawing the bg over the 
  previous frame. what a simple solution. i feel stupid
  */

  for (Note n : midiPlayer.getNotes()) {
    if (n.channel == 3 && n.on) {
      if (n.note != prevNote) {
        currentNote = n.note;
        println("current note: " + currentNote);
      }
      
      noteHeight = int(map(n.note,48,96,height,0));
      
      lines.add(new Line(width,noteHeight));
      prevNote = n.note;
    }
    
  }

  
  
 midiPlayer.update(); //idk what this does exactly; song plays without it
}
