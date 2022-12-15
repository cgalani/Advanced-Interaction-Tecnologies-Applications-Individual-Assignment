// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Exercise 16-5: Snake Class

class Snake {
  // x and y positions
  int[] xpos;
  int[] ypos;

  // The constructor determines the length of the snake
  Snake(int n) {
    xpos = new int[n];
    ypos = new int[n];
  }

  void update(int newX, int newY) {
    // Shift all elements down one spot. 
    // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. Stop at the second to last element.
    for (int i = 0; i < xpos.length-1; i ++ ) {
      xpos[i] = xpos[i+1]; 
      ypos[i] = ypos[i+1];
    }

    // Update the last spot in the array with the mouse location.
    xpos[xpos.length-1] = newX; 
    ypos[ypos.length-1] = newY;
  }

  void display() {
    // Draw everything
    for (int i = 0; i < xpos.length; i ++ ) {
      // Draw an ellipse for each element in the arrays. 
      // Color and size are tied to the loop's counter: i.
      noStroke();
      fill(255-i*5, 255, 255-i*10);
     // ellipse(xpos[i],ypos[i],i,i); 
      star(xpos[i], ypos[i], 6, 14, 5);
    }

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
}
