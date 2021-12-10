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
