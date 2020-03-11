
import android.os.Bundle;  
import android.content.Intent;  
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import processing.sound.*;
import ketai.sensors.*;

KetaiSensor sensor;
PVector accelerometer;
float light, proximity;
KetaiLocation location; // 1
double longitude, latitude, altitude;

KetaiList connectionList;  // 4
String info = "";  // 5
boolean isConfiguring = true;
String UIText;

ArrayList<String> devices = new ArrayList<String>();
boolean isWatching = false;
String message = "";
PImage img, bg, car;
SoundFile alarm;



void setup()
{
  size(1080, 1920);
  bg = loadImage("road.png");
  car = loadImage("car.png");
  img = loadImage("penguin.png");
  orientation(PORTRAIT);
  background(70, 170, 25);
  stroke(255);
  textSize(60);
  textAlign(CENTER, CENTER);
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
  location = new KetaiLocation(this);
  alarm = new SoundFile(this, "duck.mp3");

}

void draw()
{
  background(70, 170, 25);
  background(bg);
  imageMode(CORNERS);
  image(img, 0, 0, width, height/2);
  image(car, 0, height/2, width, height);
  text(message, 10, 30, width, height);
  alarm.play();
  redraw();
}
