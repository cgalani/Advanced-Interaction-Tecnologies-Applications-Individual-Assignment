import gab.opencv.*;
import processing.video.*;

Capture video;

OpenCV opencv;

void setup() {
  size(720, 480);
  video = new Capture(this, width, height);
  opencv = new OpenCV(this, 720, 480);

  opencv.startBackgroundSubtraction(5, 3, 0.5);
  
  video.start();

}

void draw() {
  image(video, 0, 0);

  if (video.width == 0 || video.height == 0)
    return;

  opencv.loadImage(video);
  opencv.updateBackground();

  opencv.dilate();
  opencv.erode();

  noFill();
  stroke(255);
  strokeWeight(4);
  for (Contour contour : opencv.findContours()) {
    contour.draw();
  }
}

void captureEvent(Capture video) {
  video.read();
}
