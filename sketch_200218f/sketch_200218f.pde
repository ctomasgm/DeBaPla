import ketai.sensors.*; 
KetaiSensor sensor; 

void setup(){
  sensor = new KetaiSensor(this); 
  sensor.start(); 
}

void draw(){
}

void onAccelerometerEvent(float x, float y, float z){ 
}
