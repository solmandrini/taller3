char val;
int ledPin = 13;

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
    if (Serial.available()) { //If data is available to read,
  val = Serial.read(); //read it and store it in val
  }
    if (val == '1') { //If 1 was received
  digitalWrite(ledPin, HIGH); // turn the LED on
  } 
    else {
  digitalWrite(ledPin, LOW); // otherwise turn it off
  }
  delay(10); // Wait 10 milliseconds for next reading
}