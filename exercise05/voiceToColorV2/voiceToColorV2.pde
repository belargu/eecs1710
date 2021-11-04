/**
Date: 11-03-2021

Description:
output a color in relation to the voice (pitch, volume)

Reference:
based off PitchDetection01.pde by Nick Fox Gieg
also this: http://code.compartmental.net/tools/minim/quickstart/
full documentation:
http://code.compartmental.net/minim/

*/

int pitch = 0;
int volume = 0;
float lowestPitch = 172;
float highestPitch = 600; //hz based off my voice
//float lowestPitch = 3000;
//float highestPitch = 6000; //hz based off my whistle
float lowestVolume = 0;
float highestVolume = 0.005;
float value;

void setup() {
  size(640,480,P2D);
  
  setupSound();
  
  colorMode(HSB);
}

void draw() {
  updateSound();
  
  //convert frequency #s to saturation/brightness equivalent
  pitch = int(map(freq,lowestPitch,highestPitch,255,0));
  volume = int(map(amp,lowestVolume,highestVolume,0,255));
  
  
  //pitch = saturation, volume = brightness
  background(0,pitch,volume);

  println("volume: " + amp + " freq: " + freq);

}
