#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 5
#define NUM_LED 480

//actual are 20 y, 24 x 
#define NUM_X 24
#define NUM_Y 20
String test = "102,135/100,105/2,225/101,135/3,225/98,165/99,165/76,135/77,135/73,225/75,135/51,225/52,165/126,135/125,135/27,165/123,225/28,195/0,100/"; 


Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LED, PIN, NEO_GRB + NEO_KHZ800);

boolean initialized = false;

int start, cap, redAmount, cellNum, comma;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(115200);
  strip.begin();
  strip.setBrightness(255);
  strip.show(); // Initialize all pixels to 'off's
}

void loop() {
  parse_red();
  delay(10);
  strip.show();
  //do_screensaver();

}

//Red value parsing
void parse_red(){
      start = 0;
      cap = test.indexOf("/", start);
      comma = test.indexOf(",", start + 1);
      cellNum = test.substring(start, comma).toInt();
      redAmount = test.substring(comma+1, cap).toInt();
      Serial.println(cellNum);
      start = cap;
      strip.setPixelColor(cellNum, strip.Color(redAmount, 0, 0));

      while (cap<test.length() - 1){
          cap = test.indexOf("/", start+1);
          comma = test.indexOf(",", start+1);
          cellNum = test.substring(start+1, comma).toInt();
          redAmount = test.substring(comma+1, cap).toInt();
          Serial.println(cellNum);
          start = cap;
         strip.setPixelColor(cellNum, strip.Color(redAmount, 0, 0));
      }
}


void do_no_motion(){
    for(int i =0; i<NUM_LED; i++){
          strip.setPixelColor(i, strip.Color(60, 0, 0)); 
          strip.show();
          delay(10);
    }
}

void do_screensaver(){
    for(int i =0; i<NUM_LED; i++){
          strip.setPixelColor(i, strip.Color(60, 0, 0)); 
          strip.show();
          delay(10);
    } 
    for(int i =0; i<NUM_LED; i++){
          strip.setPixelColor(i, strip.Color(0, 0, 60)); 
          strip.show();
          delay(5);
    }
    for(int i =0; i<NUM_LED; i++){
          strip.setPixelColor(i, strip.Color(0, 60, 0)); 
          strip.show();
          delay(10);
    }
}
