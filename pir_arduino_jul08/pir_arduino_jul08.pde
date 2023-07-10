/*
SENSOR PIR
 CONTROL de LEDS por lógica de estados
 */
import processing.sound.*;
import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;

Arduino arduino; // Declaro el objeto de Arudino

// Variables de inputs y outputs
int led_pin = 9;
int pir_pin = 4;
int switch_pin = 5;

int estado = 0;
int brillo = 255;
int timer = 0;
float resto = 0.0005;

SoundFile fondo, baseTambor, baseSuspenso, sintetizadores, combate, latidos;
float iniciaTiempo;
float volumen1, volumen2, volumen3;
boolean volumenAum1 = true;
boolean volumenAum2 = true;

void setup() {
  size( 200, 200 );
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(led_pin, Arduino.OUTPUT);
  arduino.pinMode(pir_pin, Arduino.INPUT);

  iniciaTiempo = millis();

  // --- Sonidos ---
  fondo = new SoundFile (this, "BaseFondo.wav");
  baseTambor = new SoundFile (this, "BaseTambores.wav");
  baseSuspenso = new SoundFile (this, "BaseSuspenso.wav");
  sintetizadores = new SoundFile (this, "Sintetizadores.wav");
  combate = new SoundFile (this, "Combate.wav");
  latidos = new SoundFile (this, "Latidos.wav");


  fondo.play();
  fondo.loop();

  sintetizadores.play();
  sintetizadores.loop();

  latidos.play();
  latidos.loop();

  baseTambor.play();
  baseTambor.loop();

  baseSuspenso.play();
  baseSuspenso.loop();

  combate.play();
  combate.loop();
}

void draw() {
  background( 0 );
  float medirTiempo = (millis() - iniciaTiempo) / 1000.0;
  arduino.analogWrite(led_pin, brillo);

  if ( estado == 0) {
    fondo.amp(-0.2);
    latidos.amp(-0.7);
    baseTambor.amp(-0.5);
    baseSuspenso.amp(-0.4);
    combate.amp(0.1);
    if ( timer > 30 ) {
      if ( arduino.digitalRead(pir_pin) == Arduino.HIGH ) {
        timer = 0;
        estado = 1;
      }
    }
  } else if ( estado == 1 ) {
    fondo.amp(0.2);
    latidos.amp(0.4);
    baseTambor.amp(0.1);
    baseSuspenso.amp(0.1);
    combate.amp(0.4);

    if ( frameCount % 4 == 0) {
      brillo -= 2;
      brillo = constrain(brillo, 0, 255);
      if ( brillo == 0 ) {
        estado = 2;
      }
    }
  } else if ( estado == 2 ) {
    fondo.amp(-1);
    latidos.amp(-1);
    baseTambor.amp(-1);
    baseSuspenso.amp(-1);
    combate.amp(-1);

    if ( arduino.digitalRead(switch_pin) == Arduino.HIGH ) {
      brillo = 255;
      estado = 3;
    }
  } else if ( estado == 3 ) {
    println(" Fin ");
    fondo.amp(0.0001);
    latidos.amp(0.0001);
    baseTambor.amp(0.0001);
    baseSuspenso.amp(0.0001);
    combate.amp(0.0001);
  }
  println(estado);
}

void mouseClicked() {
  if ( estado == 0 ) {
    estado = 1;
  } else if ( estado == 1 ) {
    estado = 2;
  } else if ( estado == 2 ) {
    estado = 3;
  } else if ( estado == 3 ) {
    estado = 0;
  }
}
