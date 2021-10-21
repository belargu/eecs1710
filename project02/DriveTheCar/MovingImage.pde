/**
 used for road, sky, & midgrounds in GameLevels. 
 made a class for what otherwise would be just PImages for the PVectors. those imgs need to move a lot
 */

class MovingImage {
  float x;
  PImage img;

  //only need tempX since these bgs will only move sideways
  MovingImage(String name, float tempX) {
    x = tempX;
    img = loadImage(name);
  }
}
