// ---------------------------------------------------------------------------
// Example NewPing library sketch that does a ping about 20 times per second.
// ---------------------------------------------------------------------------

#include <NewPing.h>

#define TRIGGER_PIN 6     // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN 7        // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 200  // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.
#define LED_PIN 9


int limite = 120;

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);  // NewPing setup of pins and maximum distance.

void setup() {
  pinMode(LED_PIN, OUTPUT);

  Serial.begin(115200);  // Open serial monitor at 115200 baud to see ping results.
}

void loop() {
  delay(20);  // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.
 // Serial.print("Ping: ");
 // Serial.print(sonar.ping_cm());  // Send ping, get distance in cm and print result (0 = outside set distance range)
  //Serial.println("cm");

  unsigned int distancia = sonar.ping_cm();

  int brightness = map(distancia, 25, MAX_DISTANCE, 150, 0);
  brightness = constrain(brightness, 0, 150);
  analogWrite(LED_PIN, brightness);
  Serial.println(distancia);
  
  if ( distancia > limite ) {
    //analogWrite(LED_PIN, LOW);
  }
}