/**
song class containing filename, length, tempo, etc
*/

class Song {
  String fileName;
  int voiceChannel;
  //float tempo; //get tempo from midiplayer instead since some songs speed up
  int duration; //IN SECONDS
  
  Song(String tempName, int tempChan, int tempDur) {
    fileName = tempName;
    voiceChannel = tempChan;
    duration = tempDur;
  }
}
