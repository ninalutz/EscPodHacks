LeapMotion leap;
Matrix matrix;

void setup() {
  size(800, 800);
  background(255);
  String portName = Serial.list()[2]; 
  //println(Serial.list());
  myPort = new Serial(this, portName, 115200);
  matrix = new Matrix(40, 40, 600, 600);
  leap = new LeapMotion(this);

  fingerTips = new HashSet<PVector>();
  //otherBones = new HashSet<PVector>();
}


void draw(){
  background(255);
  draw_Leap();
  matrix.draw();
}
