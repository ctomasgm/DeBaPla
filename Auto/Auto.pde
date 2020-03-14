import android.os.Bundle;  
import android.content.Intent;  
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import ketai.sensors.*;
import ketai.camera.*;
import processing.sound.*;
import cassette.audiofiles.SoundFile;

KetaiSensor sensor;
KetaiList connectionList;  
KetaiLocation location;
KetaiCamera camera;
Sound sound;
SinOsc sin;
SoundFile honk;

PVector accelerometer, rotation;
float light, proximity; 
double longitude, latitude, altitude;
String info = "";  
boolean isConfiguring = true;
String UIText;
ArrayList<String> devices = new ArrayList<String>();
boolean isWatching =  false;
String message = "", prevMessage="";
PImage img, bg, car, fondTxt;
boolean playSound=false, takePicture=false;
int tSize = 128;
String[] alerta1 = {"", "", ""};
int currentEvent = -1;
void setup()
{
  fullScreen();
  sensor = new KetaiSensor(this);
  location  = new KetaiLocation(this);
  sound = new Sound(this);
  sin = new SinOsc(this);
  accelerometer= new PVector();
  rotation = new PVector();
  img = loadImage("penguin.png");
  bg = loadImage("road.jpg");
  car = loadImage("car.png");
  fondTxt = loadImage("fondoTexto.png");
  orientation(PORTRAIT);
  fill(0);
  stroke(255);
  sensor.start();
  sensor.list();
  sensor.enableProximity();
  sensor.enableLight();
  frameRate(90);
  textFont(createFont("Candal.ttf", 40));
  honk = new SoundFile(this, "honk.mp3");
  camera = new KetaiCamera(this, width, height, 30);
  camera.setCameraID(1);
}

void draw()
{
  background(bg);
  imageMode(CORNERS); 
  tint(255, 180);
  image(fondTxt, 0, (2*height/3) -170, width, (2*height/3)+135);
  tint(255, 170);
  image(img, 0, 0, width, height/2);
  tint(255, 255);
  image(car, 0, height/2, width, height+500);
  textAlign(CENTER);
  textSize(tSize);
  while (textWidth(alerta1[0]) > width*0.75
    || textWidth(alerta1[1]) > width*0.75
    || textWidth(alerta1[2]) > width*0.75) {
    tSize--;
    textSize(tSize);
  }
  textSize(tSize);
  fill(25, 140, 180);
  text(alerta1[0], width/2, (2*height/3)-80);
  fill(10, 100, 145);
  text(alerta1[1], width/2, 2*height/3);
  fill(8, 60, 130);
  text(alerta1[2], width/2, (2*height/3)+80);
  fill(0);
  textAlign(LEFT,BOTTOM);
  textSize(35);
  text(message,0,height);
  if (currentEvent == 0) {
    camera.start();
    if (camera.isStarted()) {
      camera.savePhoto();
    }
    camera.stop();
  }
}    
