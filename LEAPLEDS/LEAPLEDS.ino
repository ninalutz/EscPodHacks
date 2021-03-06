#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
#include <avr/power.h>
#endif

#define PIN 5
#define NUM_LED 480

//actual are 20 y, 24 x
#define NUM_X 24
#define NUM_Y 20
String test = "<102,135/100,105/2,225/101,135/3,225/98,165/99,165/76,135/77,135/73,225/75,135/51,225/52,165/126,135/125,135/27,165/123,225/28,195/0,100/>";
String pretest =  "";

Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LED, PIN, NEO_GRB + NEO_KHZ800);

int start, cap, redAmount, cellNum, comma;

void setup() {
  //  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(115200);
  strip.begin();
  strip.setBrightness(255);
  strip.show(); // Initialize all pixels to 'off's
}

void loop() {

//Simple working code: 
//  if (Serial.available() > 0) {
//    Serial.println("recieved serial1");
//    pretest = Serial.readString();
//    // read incoming serial data:
//    char inChar = Serial.read();
//    // Type the next ASCII value from what you received:
//
//    if(pretest.equals("hello")){
//        do_no_motion();
//      }
//  }


if(Serial.available() > 0){
    pretest = Serial.readString();
    if(pretest.equals("hello")){
        do_no_motion();
      }
    else{
        test = pretest;
        parse_red();
      }
  }

do_screensaver();

//else{
//      do_no_motion();
//    }

/*
  if (Serial.available()) {
    Serial.println("recieved serial");

    pretest = Serial.readString();
    if (pretest.equals("hello")) {
      do_no_motion();
    }
  }

  else {
    test = "";
    do_screensaver();
  }
  */
}

//Red value parsing
void parse_red() {

  for(int i =0; i<NUM_LED; i++){
      strip.setPixelColor(i, strip.Color(0, 0, 0));
    }
  
  start = 0;
  cap = test.indexOf("/", start);
  comma = test.indexOf(",", start + 1);
  cellNum = test.substring(start, comma).toInt();
  redAmount = test.substring(comma + 1, cap).toInt();
  Serial.println(cellNum);
  start = cap;
  strip.setPixelColor(cellNum, strip.Color(redAmount, 0, 0));

  while (cap<test.length() - 1){
  //while (test[cap + 1] != ">") {
    cap = test.indexOf("/", start + 1);
    comma = test.indexOf(",", start + 1);
    cellNum = test.substring(start + 1, comma).toInt();
    redAmount = test.substring(comma + 1, cap).toInt();
    Serial.println(cellNum);
    start = cap;
    strip.setPixelColor(cellNum, strip.Color(redAmount, 255 - redAmount, 0));
  }
  strip.show();
}


void do_no_motion() {
  for (int i = 0; i < NUM_LED; i++) {
    strip.setPixelColor(i, strip.Color(10, 0, 10));
  }
  strip.show();
}

void do_screensaver() {
  for (int i = 0; i < NUM_LED; i++) {
    strip.setPixelColor(i, strip.Color(60, 0, 0));
    strip.show();
//    delay(2);
  }
  for (int i = 0; i < NUM_LED; i++) {
    strip.setPixelColor(i, strip.Color(0, 0, 60));
    strip.show();
  //  delay(2);
  }
  for (int i = 0; i < NUM_LED; i++) {
    strip.setPixelColor(i, strip.Color(0, 60, 0));
    strip.show();
//    delay(2);
  }
}

void rainbowCycle(uint8_t wait) {
  uint16_t i, j;

  for (j = 0; j < 256 * 5; j++) { // 5 cycles of all colors on wheel
    for (i = 0; i < strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel(((i * 256 / strip.numPixels()) + j) & 255));
    }
    strip.show();
    delay(wait);
  }
}

// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
uint32_t Wheel(byte WheelPos) {
  WheelPos = 255 - WheelPos;
  if (WheelPos < 85) {
    return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if (WheelPos < 170) {
    WheelPos -= 85;
    return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
}
