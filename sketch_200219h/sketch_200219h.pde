import ketai.camera.*;


KetaiCamera cam;
PImage bg, snapshot, mux;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, 1280, 768, 30);
  cam.setCameraID(1); // 1
  imageMode(CENTER);
  stroke(255);
  textSize(48);
  snapshot = createImage(1280, 768, RGB);
  bg = loadImage("rover.jpg"); // 2
  bg.resize(1280, 768);
  bg.loadPixels();
  mux = new PImage(1280, 768);
}

void draw() {
  background(0);
  if (cam.isStarted()) {
    cam.loadPixels(); // 3
    snapshot.loadPixels(); // 4
    mux.loadPixels(); // 5
    for (int i= 0; i < cam.pixels.length; i++){
      color currColor = cam.pixels[i]; // 6
      float currR = abs(red(cam.pixels[i]) - red(snapshot.pixels[i]) ); // 7
      float currG = abs(green(cam.pixels[i]) - green(snapshot.pixels[i]));
      float currB = abs(blue(cam.pixels[i]) - blue(snapshot.pixels[i]));
      float total = currR+currG+currB; // 8
      if (total < 128)
        mux.pixels[i] = bg.pixels[i]; // 9
      else
        mux.pixels[i] = cam.pixels[i]; // 10
     }
    mux.updatePixels(); // 11
    image(mux, width/2, height/2, width, height); // 12
  }
    drawUI();
}

void drawUI(){
  fill(0, 128);
  rect(0, 0, width / 4, 100);
  rect(width / 4, 0, width / 4, 100);
  rect(2 * (width / 4), 0, width / 4, 100);
  rect(3 * (width / 4), 0, width / 4 - 1, 100);
  fill(255);
  if (cam.isStarted())
    text("stop", 20, 70);
  else
    text("start", 20, 70);
  text("camera", (width / 4) + 20, 70);
  text("snapshot", 2 * (width / 4) + 20, 70);
}
void mousePressed(){
    if (mouseY <= 100)
    {
        //start/stop the camera
        if (mouseX > 0 && mouseX < width / 4)
        {
            if (cam.isStarted())
            {
                cam.stop();
            }
            else
            {
                if (!cam.start())
                    println("Failed to start camera.");
                bg.resize(cam.width, cam.height);
            }
        }
        //switch cameras
        else if (mouseX > width / 4 && mouseX < 2 * (width / 4))
        {
            int cameraID = 0;
            if (cam.getCameraID() == 0)
                cameraID = 1;
            else
                cameraID = 0;
            cam.stop();
            cam.setCameraID(cameraID);
            cam.start();
        }
        //take snapshot
        else if (mouseX > 2 * (width / 4) && mouseX < 3 * (width / 4))
        {
            cam.manualSettings(); // 1
            snapshot.copy(cam, 0, 0, cam.width, cam.height,
                          0, 0, snapshot.width, snapshot.height); // 2
            mux.resize(cam.width, cam.height);
        }
    }
}
void onCameraPreviewEvent()
{
    cam.read();
}
void exit()
{
    cam.stop();
}
