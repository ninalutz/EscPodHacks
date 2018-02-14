LeapMotion leap;

void setup() {
  size(800, 500);
  background(255);
  String portName = Serial.list()[0]; 
  myPort = new Serial(this, portName, 9600);

  leap = new LeapMotion(this);
}


void draw(){
  background(255);
  draw_Leap();
}