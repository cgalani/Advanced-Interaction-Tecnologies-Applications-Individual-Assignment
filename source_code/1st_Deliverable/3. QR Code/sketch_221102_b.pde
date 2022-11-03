import qrcodeprocessing.*;
//Create and initialize a decoder object:
Decoder decoder;
PImage img; 

void setup() {
  decoder=new Decoder(this);
  size(320, 240);
  // Make a new instance of a PImage by loading an image file
  img = loadImage("galanigthub.png");
  decoder.decodeImage(img);
}

void decoderEvent(Decoder decoder){
  String statusMsg= decoder.getDecodedString();
  println(statusMsg);
link(statusMsg);
}
