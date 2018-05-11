LeapMotion leap;
Matrix matrix;

import processing.serial.*;

void setup() {
  size(800, 800);
  background(255);
  String portName = Serial.list()[5]; 
  println(Serial.list());
  myPort = new Serial(this, portName, 115200);
  matrix = new Matrix(24, 20, 240, 200);
  leap = new LeapMotion(this);

  fingerTips = new HashSet<PVector>();
  
  frameRate(50);
}


void draw(){
  background(255);
  draw_Leap();
  matrix.draw();
  myPort.write(matrix.randomOutput());
  
}