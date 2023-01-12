import TUIO.*;
TuioProcessing tuio;
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
int posX, posY;
PFont font;
PImage img0;
PImage img1;
PImage img2;
boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks
boolean showImage = false;

void setup()
{ 
  img0 = loadImage("syros.png");
  img1 = loadImage("gata.png");
  img2 = loadImage("faros.png");
  noCursor();
  size(800,400);
  noStroke();
  fill(0);
  // periodic updates
  if (!callback) {
    frameRate(60); //<>//
    loop();
  } else noLoop(); // or callback updates 
  font = createFont("Arial", 18);
  scale_factor = height/table_size;
   // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuio  = new TuioProcessing(this);
 }
 // within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
void draw()
{
  background(255);
  textFont(font,18*scale_factor);

 ArrayList<TuioObject> tuioObjectList = tuio.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {  
TuioObject tobj = tuioObjectList.get(i);
     
      
if(tobj.getSymbolID() == 0){
  
     stroke(0);
     fill(0,0,0);
     pushMatrix();
     translate(posX, posY);
     popMatrix();
     fill(255);
     image(img0, posX, posY, width/2, height/2);
     showImage = true; }
     
     
if(tobj.getSymbolID() == 1){
  
     stroke(0);
     fill(0,0,0);
     pushMatrix();
     translate(posX, posY);
     popMatrix();
     fill(255);
     image(img1, posX, posY, width/4, height/2);
     showImage = true; }
     
     if(tobj.getSymbolID() == 2){
  
     stroke(0);
     fill(0,0,0);
     pushMatrix();
     translate(posX, posY);
     popMatrix();
     fill(255);
     image(img2, posX, posY, width/4, height/2);
     showImage = true; }
   
if (tobj.getSymbolID()==3)
{filter(INVERT);}

if (tobj.getSymbolID()==4) 
{filter(GRAY);} 

if (tobj.getSymbolID()==8)
{filter(ERODE);} 

     
  }
   
}
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
  +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
          
  posX = round(tobj.getX()*width);
  posY = round(tobj.getY()*height); 

}
// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
