import android.os.Bundle;  
import android.content.Intent;  
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import ketai.sensors.*;
import ketai.camera.*;
import processing.sound.*;

KetaiSensor sensor;
KetaiList connectionList;  
KetaiLocation location;
KetaiCamera camera;
Sound sound;
SinOsc sin;

PVector accelerometer, rotation;
float light, proximity; 
double longitude, latitude, altitude;
String info = "";  
boolean isConfiguring = true;
String UIText;
ArrayList<String> devices = new ArrayList<String>();
boolean isWatching =  false;
String message = "", prevMessage="";
PImage img, bg, car;
boolean playSound=false, isDiferent=false;

void setup()
{
  sensor = new KetaiSensor(this);
  location  = new KetaiLocation(this);
  sound = new Sound(this);
  sin = new SinOsc(this);
  accelerometer= new PVector();
  rotation = new PVector();
  img = loadImage("penguin.png");
  bg = loadImage("road2.jpg");
  car = loadImage("car.png");
  size(1080, 1920); 
  orientation(PORTRAIT);
  background(0);
  fill(0);
  stroke(255);
  sensor.start();
  sensor.list();
  sensor.enableProximity();
  sensor.enableLight();
  frameRate(15);
}

void draw()
{
  background(50);
  background(bg);
  imageMode(CORNERS);
  image(img, 0, 0, width, height/2);
  image(car, 0, height/2, width, height+500);
  textSize(60);
  textAlign(CENTER, CENTER);
  text(message, 10, 30, width, height);
  if (playSound && prevMessage!=message) {
    sin.play(700, 0.5);
    delay(250);
    sin.stop();
  } else {
    sin.stop();
  }
  prevMessage=message;
}    
