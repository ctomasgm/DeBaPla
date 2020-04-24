import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteLocation;
int y1;
float x, y, speedX, speedY;
float diam = 10;
float rectSize = 200;

void setup() {
  fill(50, 80, 120);
  reset();
  size(1080, 1920);
  oscP5 = new OscP5(this,3);
  remoteLocation = new NetAddress("192.168.137.74", 3);  // 1
  background(30, 93, 120);
}

void reset() {
  x = width/2;
  y = height/2;
  speedX = random(3, 5);
  speedY = random(3, 5);
}

void draw() { 
  background(0);
  ellipse(x, y, diam, diam);
  rect(0, 0, 20, height);
  rect(width-30, y1, 10, rectSize);

  x += speedX;
  y += speedY;

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
    lessRectSize();
  }


  // if ball hits up or down, change direction of Y   
  if ( y > height || y < 0 ) {
    speedY *= -1;
  }
}

void mousePressed() {
  reset();
}
void lessRectSize(){
   if (rectSize>99){
    rectSize-=5; 
 }
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("ii"))  
  {
    y1 =  theOscMessage.get(0).intValue();
  }
}
