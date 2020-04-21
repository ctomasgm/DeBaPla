import P5ireBase.library.*;
P5ireBase fire;
void setup() {
 size(400, 400);
 fire = new P5ireBase(this, "https://tmp1-
ae346.firebaseio.com/");
}
void draw() {
 //if(mousePressed) {
 // println("was here");
 // fire.setValue("Nombre", "Amarito");
 //}
}
void mousePressed() {
 fire.setValue("Nombre", "Amarito");
 println(fire.getValue("Last"));
}
