#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 2
#define NUM_LED 96

#define NUM_X 15
#define NUM_Y 15


Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LED, PIN, NEO_GRB + NEO_KHZ800);

String test; 


int xCoords[] = {};
int yCoords[] = {};
int redVals[] = {};

void setup() {
  strip.begin();
  strip.setBrightness(64);
  strip.show(); // Initialize all pixels to 'off'
  Serial.begin(115200);

  test = "25.0,17.0,255/23.0,16.0,255/28.0,20.0,255/20.0,16.0,255/16.0,19.0,255/15.0,19.0,225/";

  
  int oldstart = 0;
  int start = test.indexOf("/");
  int first_comma = test.indexOf(",");
  int xCoord = test.substring(oldstart, first_comma).toInt();
  int second_comma = test.indexOf(",", first_comma);
  int yCoord = test.substring(first_comma,second_comma).toInt();
  int redAmount = test.substring(second_comma, start).toInt();

  xCoords[0] = xCoord;

  int num_coords = 1;

  while(start < test.length()-1){
        start = test.indexOf("/", oldstart); 
        first_comma = test.indexOf(",");
        xCoord = test.substring(oldstart, first_comma).toInt();
        second_comma = test.indexOf(",", first_comma);
        yCoord = test.substring(first_comma,second_comma).toInt();
        redAmount = test.substring(second_comma, start).toInt();

        xCoords[num_coords] = xCoord;
        yCoords[num_coords] = yCoord;
        redVals[num_coords] = redAmount;
        num_coords+= 1;
        oldstart = start;
    }
}

int XY_to_Pixel(int x, int y){
    //changes the xy from the visualization to a pixel number
  }


void loop() {
    if(Serial.read() == 1){
        rainbowCycle(20);
    }
    
    test = Serial.read();
    
}
//
void rainbowCycle(uint8_t wait) {
  uint16_t i, j;

  for(j=0; j<256*5; j++) { // 5 cycles of all colors on wheel
    for(i=0; i< strip.numPixels(); i++) {
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
  if(WheelPos < 85) {
    return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if(WheelPos < 170) {
    WheelPos -= 85;
    return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
}
