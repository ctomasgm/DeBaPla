import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
float accelerometerX, accelerometerY, accelerometerZ;
float x, y, speedX, speedY;
float diam = 10;
float rectSize = 500;

void setup() {
  fill(50, 80, 120);
  size(1920,1080);
  oscP5 = new OscP5(this,1);
  remoteLocation = new NetAddress("192.168.137.74",1); 
  reset();
}

void reset() {
  x = width/2;
  y = height/2;
  speedX = random(3, 6);
  speedY = random(3, 6);
  rectSize = 500;
}

void draw() { 
  background(0);
  
  ellipse(x, y, diam, diam);

  rect(0, 0, 20, height);
  rect(width-30, mouseY-rectSize/2, 10, rectSize);

  x += 1.2*speedX;
  y += 1.2*speedY;

  // if ball hits movable bar, invert X direction
  if ( x > width-30 && x < width -20 && y > mouseY-rectSize/2 && y < mouseY+rectSize/2 ) {
    speedX = speedX * -1;
    lessRectSize();
  } 

  // if ball hits wall, change direction of X
  if (x < 25) {
    speedX *= -1.1;
    speedY *= 1.1;
    x += speedX;
  }


  // if ball hits up or down, change direction of Y   
  if ( y > height || y < 0 ) {
    speedY *= -1;
  }
  textAlign(CENTER,CENTER);
  text("Remote Accelerometer Info: " + "\n" + 
  "x " + nfp(accelerometerX,1,3) + "\n" +
  "y " + nfp(accelerometerY,1,3) + "\n" +
  "z " + nfp(accelerometerZ,1,3) + "\n" +
  "Local Info: \n" +
  "mousePressed " + mousePressed, width/2,height/2);
  
  OscMessage myMessage = new OscMessage("mouseStatus");
  myMessage.add(mouseX);
  myMessage.add(mouseY);
  myMessage.add(int(mousePressed));
  oscP5.send(myMessage,remoteLocation);

}

void mousePressed() {
  reset();
}

void oscEvent(OscMessage theOscMessage){
  if(theOscMessage.checkTypetag("fff")){
    accelerometerX = theOscMessage.get(0).floatValue();
    accelerometerY = theOscMessage.get(1).floatValue();
    accelerometerZ = theOscMessage.get(2).floatValue();
  }
}

void lessRectSize(){
   if (rectSize>99){
    rectSize-=5; 
 }
}
