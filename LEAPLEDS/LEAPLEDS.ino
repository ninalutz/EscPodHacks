#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 5
#define NUM_LED 480

//actual are 20 y, 24 x 
#define NUM_X 24
#define NUM_Y 20


Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LED, PIN, NEO_GRB + NEO_KHZ800);

String test;
int redVals[] = {};
boolean initialized = false;


void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(115200);
  strip.begin();
  strip.setBrightness(255);
  strip.show(); // Initialize all pixels to 'off's
  
  test = "102,135/100,105/2,225/101,135/3,225/98,165/99,165/76,135/77,135/73,225/75,135/51,225/52,165/126,135/125,135/27,165/123,225/28,195/0,100"; 

//  parse_red(test);

}

void loop() {
//    test = Serial.readString();
//    if(test.length() > 0) parse_red(test);
//    else do_dull();

  do_screensaver();

}

//Red value parsing
void parse_red(String t){
  
      int start = 0;
      int cap = test.indexOf("/", start);
      int comma = test.indexOf(",", start);
      int cellNum = test.substring(start, comma).toInt();
      int redAmount = test.substring(comma+1, cap).toInt();

      start = cap;
      
      redVals[cellNum] = redAmount;


      while (cap<test.length() - 1){
          cap = test.indexOf("/", start+1);
          comma = test.indexOf(",", start+1);
          cellNum = test.substring(start+1, comma).toInt();
          redAmount = test.substring(comma+1, cap).toInt();
          start = cap;
          
//          Serial.println(cellNum);
          redVals[cellNum] = redAmount;
      }
      
    for(int i =0; i<NUM_LED; i++){
          strip.setPixelColor(i, strip.Color(redVals[i], 10, 0)); 
    }
  strip.show();

  delay(2000);

       
}

void do_dull(){
    
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
