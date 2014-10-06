int sensorPin = A0;    // select the input pin for the potentiometer
//int ledPin = 13;      // select the pin for the LED
int sensorRed = 0;  // variable to store the value coming from the sensor
int countRed = 0;
int prevRed = -1;

int sensorPin2 = A1;
int sensorGreen = 0;
int countGreen = 0;
int prevGreen = -1;

// the piezo is connected to analog pin 3
const int hitSensor = A3; 
// threshold value to decide when the detected sound is a hit or not
const int threshold = 0; 
// variable to store the value read from the sensor pin
int sensorReading = 0;    

void setup() {
  // declare the ledPin as an OUTPUT:
  //pinMode(ledPin, OUTPUT);
  Serial.begin(9600); 
}

void loop() {
  
  //wires code ::

  // read the value from the sensor:
  sensorRed = analogRead(sensorPin);
  prevRed = sensorRed;
  
  sensorGreen = analogRead(sensorPin2);
  prevGreen = sensorGreen; 
  
  //Serial.println(sensorRed);
  
  if (sensorRed == 0 && prevRed == 0) {
    ++countRed;
  }
  else {
    countRed = 0;
  }
  
  if (sensorGreen == 0 && prevGreen == 0) {
    ++countGreen;
  }
  else {
    countGreen = 0;
  }
  
  if (countRed >= 15) {
    //Serial.println("green crap");
    Serial.write(1);
    countRed = 0;
  }
  else if (countGreen >= 15) {
    //Serial.println("red crap");
    Serial.write(2);
    countGreen = 0;
  }
  else {
    Serial.write(0);
  }
  
  
  //code for the piezo :
  
  // read the sensor and store it in the variable sensorReading:
  sensorReading = analogRead(hitSensor);
  Serial.println(sensorReading);  //test
  
  // if the sensor reading is greater than the threshold:
  if (sensorReading > threshold) {
  //then we send the value of 3 to processing
    Serial.write(3);  
    }
  
  delay(50);
  
}
