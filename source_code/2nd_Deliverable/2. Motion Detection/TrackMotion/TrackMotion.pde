// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Exercise 16-7: Create a sketch that looks for the average location 
// of motion. Can you have an ellipse follow your waving hand?   

import processing.video.*;

// Variable for capture device
Capture video;
// Previous Frame
PImage prevFrame;

// How different must a pixel be to be a "motion" pixel
float threshold = 80;

void setup() {
  size(320, 240);
  // Using the default capture device
  video = new Capture(this, 320, 240);
  video.start();

  // Create an empty image the same size as the video
  prevFrame = createImage(video.width, video.height, RGB);
}

// New frame available from camera
void captureEvent(Capture video) {
  // Save previous frame for motion detection!!
  prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  prevFrame.updatePixels();  
  video.read();
}


void draw() {
  background(0);

  // You don't need to display it to analyze it!
  image(video, 0, 0);


  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();

  // These are the variables we'll need to find the average X and Y
  float sumX = 0;
  float sumY = 0;
  int motionCount = 0; 

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      // What is the current color
      color current = video.pixels[x+y*video.width];

      // What is the previous color
      color previous = prevFrame.pixels[x+y*video.width];

      // Step 4, compare colors (previous vs. current)
      float r1 = red(current); 
      float g1 = green(current);
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous);
      float b2 = blue(previous);

      // Motion for an individual pixel is the difference between the previous color and current color.
      float diff = dist(r1, g1, b1, r2, g2, b2);

      // If it's a motion pixel add up the x's and the y's
      if (diff > threshold) {
        sumX += x;
        sumY += y;
        motionCount++;
      }
    }
  }

  // average location is total location divided by the number of motion pixels.
  float avgX = sumX / motionCount; 
  float avgY = sumY / motionCount; 

star(avgX, avgY, 30, 70, 5);
fill (200, 100, 0);

}

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
