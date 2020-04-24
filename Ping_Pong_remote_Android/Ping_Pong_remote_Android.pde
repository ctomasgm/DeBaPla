import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
int x, y;
PImage img,img2;

void setup() {
  orientation(PORTRAIT);
  oscP5 = new OscP5(this, 3);  
  remoteLocation = new NetAddress("192.168.1.84", 3);  // 1
  img = loadImage("penguin.jpg");
  img2 = loadImage("replay.png");
}

void draw() {
  stroke(0);
  background(10, 20, 40);
  image(img2,0,0,150,150);
  image(img,mouseX,mouseY,200,200);
  if (mousePressed) {
    stroke(255);
    OscMessage myMessage = new OscMessage("AndroidData"); 
    myMessage.add(mouseX);
    myMessage.add(mouseY);
    oscP5.send(myMessage, remoteLocation);
  }
}
