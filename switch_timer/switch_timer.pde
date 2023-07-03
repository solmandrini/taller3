import processing.serial.*;

import cc.arduino.*;
import org.firmata.*;

Arduino arduino;

int detectoPersona = 0;
int timer = 0;
float resto = 0.0005;
int brillo = 255;


// --- inputs y outputs
int led = 10;
int pir = 4;
int boton = 3;

void setup() {
  size(880, 540);
  arduino = new Arduino(this, Arduino.list()[0], 57600);

  //for (int i = 0; i <= 53; i++)
  //  arduino.pinMode(i, Arduino.INPUT);
  arduino.pinMode(led, Arduino.OUTPUT);
  arduino.pinMode(pir, Arduino.INPUT);
  arduino.pinMode(boton, Arduino.INPUT);
}

void draw() {
  background(0);
  arduino.analogWrite(led, brillo);
  if ( detectoPersona == 0 ) {
    timer++;
    println(timer);
    if ( timer >= 100 ) {
      if ( arduino.digitalRead(pir) == Arduino.HIGH ) {
        timer = 0;
        detectoPersona = 1;
      }
    }
  }
  if ( detectoPersona == 1) {
    if ( frameCount % 2 == 0) {

      brillo -= 2;
      brillo = constrain(brillo, 0, 255);
      if ( brillo == 0 ) {
        detectoPersona = 2;
      }
    }
    println(brillo);
  } else if ( detectoPersona == 2) {
    println("Cambió de estado");
    if ( arduino.digitalRead(boton) == Arduino.HIGH) {
      brillo = 255;
    }
  }
}
