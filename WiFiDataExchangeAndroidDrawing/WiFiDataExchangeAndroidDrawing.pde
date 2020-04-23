import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
int x, y, px, py;

void setup() {
  orientation(PORTRAIT);
  oscP5 = new OscP5(this, 12000);  
  remoteLocation = new NetAddress("192.168.1.90", 12000);  // 1
  background(78, 93, 75);
}

void draw() {
  stroke(0);
  float remoteSpeed = dist(px, py, x, y);                 // 2
  if (remoteSpeed < 100) strokeWeight(remoteSpeed);       // 3
  line(px, py, x, y);                                     // 4
  px = x;                                                 // 5
  py = y;                                                 // 6
  if (mousePressed) {
    stroke(255);
    float speed = dist(pmouseX, pmouseY, mouseX, mouseY); // 7
    strokeWeight(speed);                                  // 8
    if (speed < 100) line(pmouseX, pmouseY, mouseX, mouseY); // 9
    OscMessage myMessage = new OscMessage("AndroidData"); 
    myMessage.add(mouseX); 
    myMessage.add(mouseY);
    oscP5.send(myMessage, remoteLocation);
  }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("iii"))  
  {
    x =  theOscMessage.get(0).intValue();
    y =  theOscMessage.get(1).intValue();
  }
}
