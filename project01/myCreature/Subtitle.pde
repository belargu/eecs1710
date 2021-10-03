class Subtitle {
  String[] petLines = {"that tickles!", "thank you for petting", 
  "i trust you more now...", "feels nice","ahhh...","thanks","hehehe"};
  String[] hitLines = {"ow!","stop it!","ouch!", "yowee!", "no!!!","that hurts!",
  "enough!","it hurts... it hurts so much","why did god put me on this earth?"};
  String[] scareLines = {"ahhh!","that startled me!","don't do that!","woah!",
  "you scared me!","stop that i'm gonna cry"};
  String[] eatLines = {"yum...","it's a bit stale.","thank you for this meal",
  "delicious food","nomnomnom","tastes good","oh man i'm starving","that was nice"};
  String foodLine = "placed a ";
  String deadLine = "The creature has died.";
  String escapedLine = "The creature has escaped.";
  String idle = "";
  
  String currentLine;

  Subtitle() {
    currentLine = idle;
  }
  
  void draw() {
    fill(yellow);
    textFont(times);
    textSize(48);
    textAlign(CENTER);
    
    text(currentLine,width/2,height-48);
    ;
  }
}
