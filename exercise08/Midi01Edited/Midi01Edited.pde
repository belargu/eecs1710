import themidibus.*;

MidiBus myBus;
int channel = 0;
int pitch, velocity, noteHeight;
//ArrayList<Dot> dots;
ArrayList<Line> lines;
float scrollSpeed = 1;

void setup() {
  size(640, 480, P2D);
  strokeWeight(5);
  stroke(255, 255, 0);

  MidiBus.list();
  myBus = new MidiBus(this, -1, 2); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  //dots = new ArrayList<Dot>();
  lines = new ArrayList<Line>();
}

void draw() {
  background(0);
  
  /**
  for (Line i : lines) {
    line(i.x, i.y1, i.x, i.y2);
    i.x -= scrollSpeed;
  }
  */
  
  for (int i=lines.size()-1; i>=0; i--) {
    Line line = lines.get(i);
    if (line.x >= 0) {
      line(line.x, line.y1, line.x, line.y2);
      line.x -= scrollSpeed;
    } else {
      lines.remove(i);
      println("line removed");
    }
  }
  
  
  /**
  for (int i=dots.size()-1; i>=0; i--) {
    Dot dot = dots.get(i);
    if (dot.alive) {
      dot.run();
    } else {
      dots.remove(i);
    }
  }
  */
}

void mousePressed() {
  //instead of 0-127, reduce range to be more human voice like... kinda
  pitch = int(map(mouseY, height, 0, 36, 84));
  velocity = 127;
  //velocity = int(map(mouseX, 0, width, 0, 127));
  myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  
  noteHeight = int(map(pitch,36,84,height,0));
  println(noteHeight);
  
  lines.add(new Line(width/2,noteHeight));
  
  //dots.add(new Dot(mouseX, mouseY, velocity + 10));
}

void mouseReleased() {
  myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
}
