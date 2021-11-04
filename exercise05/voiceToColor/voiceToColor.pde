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

//import ddf.minim.*;

Minim minim;
AudioPlayer player;
//AudioInput in;

int pitch = 0;
int volume = 0;
float lowestPitch = 172;
float highestPitch = 600;
float value;

void setup() {
  size(640,480,P2D);
  
  /*
  minim = new Minim(this);
  
  in = minim.getLineIn();
  in.enableMonitoring(); 
  */
  
  colorMode(HSB);
}

void draw() {

  //get frequency
  
  
  //convert frequency #s to saturation/brightness equivalent
  pitch = int(map(value,lowestPitch,highestPitch,0,255));
  
  
  //pitch = saturation, volume = brightness
  background(0,pitch,volume);
  stroke(255);
  
  /*
  //represent with waveforms
  for(int i = 0; i < in.bufferSize() - 1; i++) { 
    line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 ); 
    line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 ); 
  } 
  
  String monitoringState = in.isMonitoring() ? "enabled" : "disabled"; 
  text( "in monitoring is currently " + monitoringState + ".", 5, 15 );
  */
}

/**
void keyPressed() { 
  if ( key == 'm' || key == 'M' ) { 
    if ( in.isMonitoring() ) { 
      in.disableMonitoring(); 
    } else { 
      in.enableMonitoring(); 
    } 
  } 
} 
*/
