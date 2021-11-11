/** 
filters used to alter imgs
mostly taken from other code
sources are in myDitheringV2 references
*/

//gets index of pixel using coordinates
//used in dither()
int index(int x, int y) {
  return x + y * ditheredImg.width;
}

void dither(PImage img) {
  img.loadPixels();
  for (int y = 0; y < img.height-1; y++) {
    for (int x = 1; x < img.width-1; x++) {
      color pix = img.pixels[index(x, y)];
      float oldR = red(pix);
      float oldG = green(pix);
      float oldB = blue(pix);
      int factor = 1;
      int newR = round(factor * oldR / 255) * (255/factor);
      int newG = round(factor * oldG / 255) * (255/factor);
      int newB = round(factor * oldB / 255) * (255/factor);
      img.pixels[index(x, y)] = color(newR, newG, newB);

      float errR = oldR - newR;
      float errG = oldG - newG;
      float errB = oldB - newB;

      //changing pixel right of index
      int index = index(x+1, y  );
      color c = img.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + errR * 7/16.0;
      g = g + errG * 7/16.0;
      b = b + errB * 7/16.0;
      img.pixels[index] = color(r, g, b);
      
      //changing pixel southwest of index
      index = index(x-1, y+1  );
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 3/16.0;
      g = g + errG * 3/16.0;
      b = b + errB * 3/16.0;
      img.pixels[index] = color(r, g, b);
      
      //changing pixel below index
      index = index(x, y+1);
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 5/16.0;
      g = g + errG * 5/16.0;
      b = b + errB * 5/16.0;
      img.pixels[index] = color(r, g, b);

      //changing pixel southeast of index
      index = index(x+1, y+1);
      c = img.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + errR * 1/16.0;
      g = g + errG * 1/16.0;
      b = b + errB * 1/16.0;
      img.pixels[index] = color(r, g, b);
    }
  }
  img.updatePixels();
}

//credit to me i figured this out myself
//still citing the references bc i did read them to understand
void hueSatBri(int val, int xPos, int yPos, PImage input,PImage output) {
  //needs input & output img; input img always orig img
  //if pixels use output as reference, color values will get stuck at some point
  input.loadPixels();
  output.loadPixels();
  
  //convert imgmode to HSB
  colorMode(HSB);

  //mouseX = saturation, mouseY = brightness
  int addSat = int(map(xPos,0,img.width,-255,255));
  int addBri = int(map(yPos,0,img.height,128,-128)); //reversed; up=light, down=dark
  
  
  //change pixel
  for (int i = 0; i < input.pixels.length; i++) {
    //hue code
    int newHue = int(hue(img.pixels[i])+val);
    //loop hue back around if out of bounds
    if (newHue < 0) {
      newHue+=255;
    } else if (newHue > 255) {
      newHue-=255;
    }
    
    output.pixels[i] = color(newHue,
    saturation(input.pixels[i]) + addSat,
    brightness(input.pixels[i]) + addBri);
    
  }
  
  input.updatePixels();
  output.updatePixels();

  //convert back to rgb
  colorMode(RGB);
}

/**
void changeHue(int val, PImage img) {
  img.loadPixels();
  colorMode(HSB);
  for (int i = 0; i < img.pixels.length; i++) {
    int newHue = int(hue(img.pixels[i])+val);
    //loop hue back around if out of bounds
    if (newHue < 0) {
      newHue+=255;
    } else if (newHue > 255) {
      newHue-=255;
    }
    
    //change pixel
    img.pixels[i] = color(newHue,saturation(img.pixels[i]),
    brightness(img.pixels[i]));
    
    
  }
  img.updatePixels();
  colorMode(RGB);
}
*/
