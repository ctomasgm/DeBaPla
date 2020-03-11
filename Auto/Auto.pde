import android.os.Bundle;  
import android.content.Intent;  
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import ketai.sensors.*;

KetaiSensor sensor;
KetaiList connectionList;  
KetaiLocation location;

PVector accelerometer, rotation;
float light, proximity; 
double longitude, latitude, altitude;
String info = "";  
boolean isConfiguring = true;
String UIText;
ArrayList<String> devices = new ArrayList<String>();
boolean isWatching = false;
String message = "";
PImage img, bg, car;


void setup()
{
  size(1080, 1920); 

  bg = loadImage("road.png");
  car = loadImage("car.png");
  img = loadImage("penguin.png");
  orientation(PORTRAIT);
  background(70, 170, 25);
  stroke(255);
  sensor = new KetaiSensor(this);
  accelerometer = new PVector();
  location = new KetaiLocation(this);
  rotation      = new PVector();
  sensor.start();
  sensor.list();
}

void draw()
{
  background(70, 170, 25);
  background(bg);
  imageMode(CORNERS);
  image(img, 0, 0, width, height/2);
  image(car, 0, height/2, width, height);
  textSize(60);
  textAlign(CENTER, CENTER);
  text(message, 10, 30, width, height);
  redraw();
}    
