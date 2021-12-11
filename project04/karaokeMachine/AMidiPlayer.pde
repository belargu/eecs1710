/**
the midi player & the note class
source: 
https://github.com/hamoid/Fun-Programming/tree/master/processing/ideas/2017/
04/MidiViz
*/

import java.util.concurrent.ConcurrentHashMap;

class AMidiPlayer implements Receiver {
  Sequencer sequencer;
  // Concurrent, so it can be accessed by the Processing main thread, and the
  // midi player thread without crashing.
  ConcurrentHashMap<Integer, Note> midiData = new ConcurrentHashMap<Integer, Note>();

  public void load(String path) {
    File midiFile = new File(path);
    try {
      sequencer = MidiSystem.getSequencer();
      if (sequencer == null) {
        println("No midi sequencer");
        exit();
      } else {
        sequencer.open();
        Transmitter transmitter = sequencer.getTransmitter();
        transmitter.setReceiver(this);
        Sequence seq = MidiSystem.getSequence(midiFile);
        sequencer.setSequence(seq);
      }
    } 
    catch(Exception e) {
      e.printStackTrace();
      exit();
    }
  }

  public void start() {
    sequencer.start();
  }
  
  public void stop() {
    sequencer.stop();
  }

  public void update() {
    for (Note n : midiData.values()) {
      if (n.dying > 0) {
        n.dying++;
        
        if (n.dying > 10) {
          int id = n.channel * 1000 + n.note;
          midiData.remove(id);
        }
      } else {
        n.living++;    
      }
    }
  }

  public float getBPM() {
    return sequencer.getTempoInBPM();
  }

  public Collection<Note> getNotes() {
    return midiData.values();
  }

  // When I say "send" I mean "receive" :)
  @Override public void send(MidiMessage message, long t) {
    if (message instanceof ShortMessage) {
      ShortMessage sm = (ShortMessage) message;
      int cmd = sm.getCommand(); 
      if (cmd == ShortMessage.NOTE_ON || cmd == ShortMessage.NOTE_OFF) {
        int channel = sm.getChannel() - 1;      
        int note = sm.getData1();
        int velocity = sm.getData2();
        int id = channel * 1000 + note;
        if (cmd == ShortMessage.NOTE_ON && velocity > 0) {
          midiData.put(id, new Note(channel, note, velocity, true));   
        } else {
          midiData.get(id).on = false;
          if (channel == 3) {
            //println("note off");
          }
          midiData.get(id).dying++;
        }
      }
    }
  }

  @Override public void close() {
  }
}

/*------------------------------------------------------------*/

class Note {
  int channel;
  int note;
  int velocity;
  int living;
  int dying;
  boolean on;
  
  Note(int c, int n, int v, boolean o) {
    channel = c;
    note = n;
    velocity = v;
    on = o;
  }
  void update() {
  }
}
