  
import android.os.Bundle;  // 1
import android.content.Intent;  // 2

import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

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

void setup()
{
  orientation(PORTRAIT);
  background(0, 102, 153);
  stroke(255);
  textSize(60);
  textAlign(CENTER, CENTER);
  
  sensor = new KetaiSensor(this);
  sensor.start();
  sensor.list();
  accelerometer = new PVector();
  location = new KetaiLocation(this);
}

void draw()
{
  background(0, 102, 153);
  text(message, 10, 30, width, height);
  redraw();////////////
}
