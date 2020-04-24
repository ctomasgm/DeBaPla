import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
int x, y;

void setup() {
  orientation(PORTRAIT);
  oscP5 = new OscP5(this, 3);  
  remoteLocation = new NetAddress("192.168.1.90", 3);  // 1
  background(78, 93, 75);
}

void draw() {
  stroke(0);
  if (mousePressed) {
    stroke(255);
    OscMessage myMessage = new OscMessage("AndroidData"); 
    myMessage.add(mouseY);
    oscP5.send(myMessage, remoteLocation);
  }
}
