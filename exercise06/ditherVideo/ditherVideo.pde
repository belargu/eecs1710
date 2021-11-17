/**
Date: 11-17-2021
Description:
video capture with dithering filter
i really really like dithering
video stutters a LOT bc floyd steinberg dithering is slow

References:
Prof Fox Gieg's Video01.pde & Threshold01.pde
Daniel Shiffman's dithering: code https://www.youtube.com/watch?v=0L2n8Tg2FwI
try ordered dithering (faster) when i have time:
https://www.codeproject.com/Articles/5259216/Dither-Ordered-and-Floyd-Steinberg-Monochrome-Colo
*/
void setup() {
  size(600, 450, P2D);
  
  videoSetup();
}


void draw() { 
  background(0);
  //image(capture,0,0); 
  
  dither(videoImg);
  image(videoImg,0,0);
}
