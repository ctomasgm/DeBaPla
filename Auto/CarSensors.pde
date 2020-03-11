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
  String alerta = ""; 
  switch(event) { 
  case Eventos.PROXIMITY_EVENT:
    alerta1[0]="Posible";
    alerta1[1]="Intruso";
    alerta1[2]="Husmeando";
    img = loadImage("intruso.png");  
    alerta = ""; 
    break;
  case Eventos.TOUCH_EVENT:
    alerta1[0]="Alguien intenta";
    alerta1[1]="Abrir o ha roto";
    alerta1[2]="los cristales";
    img = loadImage("broken.png");
    alerta = ""; 
    break;
  case Eventos.CAR_DISTURBANCE_EVENT:
    alerta1[0]="Probable impacto";
    alerta1[1]="o Robo de ";
    alerta1[2]="Autopartes Externas";
    img = loadImage("choque.png");
    break;
  case Eventos.INTRUDER_EVENT:
    alerta1[0]="Intruso";
    alerta1[1]="En el";
    alerta1[2]="Auto";
    img = loadImage("cars.png");
    alerta = ""; 
    break;
  case Eventos.GPS_EVENT:
    alerta = "x: " + nfp(accelerometer.x, 1, 2) + "\n"
      + "y: " + nfp(accelerometer.y, 1, 2) + "\n"
      + "z: " + nfp(accelerometer.z, 1, 2) + "\n"
      + "Rotation : " + "\n"
      + "x: " + nfp(rotation.x, 1, 2) + "\n"
      + "y: " + nfp(rotation.y, 1, 2) + "\n"
      + "z: " + nfp(rotation.z, 1, 2) + "\n"+"Latitude: " + latitude + "\n" + 
      "Longitude: " + longitude + "\n" +
      "Altitude: " + altitude + "\n";
    alerta1[0]="El Automovil esta";
    alerta1[1]="En movimiento.";
    alerta1[2]="Posible Robo";
    img = loadImage("robo.jpg");
    break;
  default:
    alerta= "";
    alerta1[0] = "";
    alerta1[1  ] = "";
    alerta1[2] = "";
    img=loadImage("penguin.png");
    background(180, 235, 175);
    break;
  }
  if (currentEvent != event && event >= 0 & event <=4) {
    honk.play();
  }
  currentEvent = event;
  message = alerta;
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
  } else if (accelerometer.x > 3.00 && accelerometer.z > 2.00 ||accelerometer.x < -3.00 && accelerometer.z > 2.00) {
    eventInTheCar(Eventos.CAR_DISTURBANCE_EVENT);
  } else if (light > 1000.0) {
    eventInTheCar(Eventos.INTRUDER_EVENT);
  } else if (proximity <= 1.0) {
    eventInTheCar(Eventos.PROXIMITY_EVENT);
  } else if (latitude != 0 && longitude != 0 && accelerometer.y < -2.00 && accelerometer.z > 0.00) {
    eventInTheCar(Eventos.GPS_EVENT);
  } else {
    eventInTheCar(-1);
  }
}
