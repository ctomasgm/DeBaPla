void onAccelerometerEvent(float x, float y, float z) {
  accelerometer.set(x, y, z);
  testSensorEvent();
}

void onLightEvent(float v) {
  light = v;
  testSensorEvent();
}

void onProximityEvent(float v) {
  proximity = v;
  testSensorEvent();
}

void onLocationEvent(double _latitude, double _longitude, double _altitude) {
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  testSensorEvent();
}
void onGyroscopeEvent(float x, float y, float z) {
  rotation.x = x;
  rotation.y = y;
  rotation.z = z;
  testSensorEvent();
}

void eventInTheCar(int event) {
  if (event < 0 || event > 4) return;
  String alerta = ""; 
  switch(event) { 
  case Eventos.PROXIMITY_EVENT:
    alerta = "POSIBLE INTRUSO HUSMEANDO";
    img = loadImage("intruso.png");  
    break;
  case Eventos.TOUCH_EVENT:
    alerta = "ALGUIEN INTENTA ABRIR O HA ROTO LOS CRISTALES";
    img = loadImage("broken.png");
    break;
  case Eventos.CAR_DISTURBANCE_EVENT:
    alerta = "PROBABLE IMPACTO O ROBO DE AUTOPARTES EXTERNAS";
    img = loadImage("choque.png");
    break;
  case Eventos.INTRUDER_EVENT:
    alerta = "INTRUSO EN EL AUTO";
    img = loadImage("cars.png");
    break;
  case Eventos.GPS_EVENT:
    alerta = "EL AUTOMOVIL ESTA EN MOVIMIENTO. POSIBLE ROBO"+"\nAccelerometer :" + "\n"
    + "x: " + nfp(accelerometer.x, 1, 2) + "\n"
    + "y: " + nfp(accelerometer.y, 1, 2) + "\n"
    + "z: " + nfp(accelerometer.z, 1, 2) + "\n"
    + "Rotation : " + "\n"
    + "x: " + nfp(rotation.x, 1, 2) + "\n"
    + "y: " + nfp(rotation.y, 1, 2) + "\n"
    + "z: " + nfp(rotation.z, 1, 2) + "\n"+"Latitude: " + latitude + "\n" + 
    "Longitude: " + longitude + "\n" +
    "Altitude: " + altitude + "\n";
    img = loadImage("robo.jpg");
    break;
  }
  message = alerta;
  //println("Se ha levantado la siguiente alerta: " + alerta + "\n Pero no hay dispositivo que nos escuche.");
}

class Eventos {
  static final int PROXIMITY_EVENT = 0;
  static final int TOUCH_EVENT = 1;
  static final int CAR_DISTURBANCE_EVENT = 2;
  static final int INTRUDER_EVENT = 3;
  static final int GPS_EVENT = 4;
}


void testSensorEvent() {
  if (touchIsStarted) {
    eventInTheCar(Eventos.TOUCH_EVENT);
  } else if (accelerometer.x > 3.00 && accelerometer.z > 2.00) {
    eventInTheCar(Eventos.CAR_DISTURBANCE_EVENT);
  } else if (light > 80.0) {
    eventInTheCar(Eventos.INTRUDER_EVENT);
  } else if (proximity == 0.0) {
    eventInTheCar(Eventos.PROXIMITY_EVENT);
  } else if (latitude != 0 && longitude != 0 && accelerometer.y < -2.00 && accelerometer.z > 0.00) {
    eventInTheCar(Eventos.GPS_EVENT);
  }
}
