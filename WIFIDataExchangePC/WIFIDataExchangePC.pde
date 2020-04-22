import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
float accelerometerX, accelerometerY, accelerometerZ;

void setup (){ 
  size(1000,1000);
  oscP5 = new OscP5(this,12000);
  remoteLocation = new NetAddress("192.168.1.66",12000); 
  textAlign(CENTER,CENTER);
  textSize(24);
}
void draw(){
  text("Remote Accelerometer Info: " + "\n" + 
  "x " + nfp(accelerometerX,1,3) + "\n" +
  "y " + nfp(accelerometerY,1,3) + "\n" +
  "z " + nfp(accelerometerZ,1,3) + "\n" +
  "Local Info: \n" +
  "mousePressed " + mousePressed, width/2,height/1);
  
  OscMessage myMessage = new OscMessage("mouseStatus");
  myMessage.add(mouseX);
  myMessage.add(mouseY);
  myMessage.add(int(mousePressed));
  oscP5.send(myMessage,remoteLocation);
}

void oscEvent(OscMessage theOscMessage){
  if(theOscMessage.checkTypetag("fff")){
    accelerometerX = theOscMessage.get(0).floatValue();
    accelerometerY = theOscMessage.get(1).floatValue();
    accelerometerZ = theOscMessage.get(2).floatValue();
  }
}
