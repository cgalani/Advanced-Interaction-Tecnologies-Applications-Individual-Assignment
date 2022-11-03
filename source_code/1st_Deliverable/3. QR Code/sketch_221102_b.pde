import qrcodeprocessing.*;
//Create and initialize a decoder object:

PImage img; 

void setup() {
  size(320, 240);
  // Make a new instance of a PImage by loading an image file
  img = loadImage("galanigthub.png");
}

void draw() {
  background(0);
  // The image() function displays the image at a location
  // in this case the point (0,0).
  image(img, -1, 0, width, height);
}
