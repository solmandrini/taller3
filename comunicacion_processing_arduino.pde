

/*
09 DE JULIO
 Comunicacion por puerto serial
 */

import processing.serial.*;
import processing.sound.*;

Serial puerto; // Declaro el objeto de la clase Serial
float value;

// --- Variables globales de calibración ---
float MIN_DISTANCIA = 0;
float MAX_DISTANCIA = 150;
float amortiguacion = 0.9;
boolean monitor = true;

GestorSenial gValue;

// --- Sonidos
SoundFile fondo, baseTambor, baseSuspenso, sintetizadores, combate, latidos;

void setup() {
  size( 800, 800 );

  String nombrePuerto = Serial.list()[0]; // Guardo en una variable el puerto disponible
  puerto = new Serial(this, nombrePuerto, 9600); // Abro el puerto especificado arriba
  puerto.bufferUntil('\n'); // Establece un byte específico en el búfer hasta antes de llamar al evento

  gValue = new GestorSenial( MIN_DISTANCIA, MAX_DISTANCIA, amortiguacion );

  fondo = new SoundFile (this, "BaseFondo.wav");
  baseTambor = new SoundFile (this, "BaseTambores.wav");
  baseSuspenso = new SoundFile (this, "BaseSuspenso.wav");
  sintetizadores = new SoundFile (this, "Sintetizadores.wav");
  combate = new SoundFile (this, "Combate.wav");
  latidos = new SoundFile (this, "Latidos.wav");

  iniciarSonidos();
}

void draw() {
  background( 0 );
  fill(255);
  textSize(20);

  gValue.actualizar( value );
  float distancia = map(gValue.filtradoNorm(), 0, 1, 0, 200);

  if ( distancia > 20 && distancia < 60 ) {
    controlarVolumen( 0.002 );
  } else if ( distancia > 60 && distancia < 100 ) {
    controlarVolumen( 0.4 );
  } else if ( distancia > 100 ) {
    controlarVolumen ( 1.0 );
  }

  if (monitor) {
    gValue.imprimir ( 100, 100, 400, 200 );
  }

  text("Distancia captada: ", width/2 - 200, height/2);
  text(distancia, width/2, height/2);
}

void serialEvent (Serial puerto) {
  String inString = puerto.readStringUntil('\n'); // Leo los Strings y los almaceno en la variable
  value = float(inString); // Convierto la variable en un dato numérico
}

void iniciarSonidos() {
  float amperaje = 0.0001;
  fondo.loop();
  fondo.play();
  fondo.amp( amperaje );

  baseTambor.loop();
  baseTambor.play();
  baseTambor.amp( amperaje );

  baseSuspenso.loop();
  baseSuspenso.play();
  baseSuspenso.amp( amperaje );

  sintetizadores.loop();
  sintetizadores.play();
  sintetizadores.amp( amperaje );

  combate.loop();
  combate.play();
  combate.amp ( amperaje );

  latidos.loop();
  latidos.play();
  latidos.amp( amperaje );
}

void controlarVolumen( float amperaje ) {
  float amp = amperaje;

  fondo.amp( amp );
  baseTambor.amp( amp );
  baseSuspenso.amp( amp );
  sintetizadores.amp( amp );
  combate.amp ( amp );
  latidos.amp( amp );

  println( amp );
}

void detenerCanciones( ) {
  fondo.pause();
  baseTambor.pause();
  baseSuspenso.pause();
  sintetizadores.pause();
  combate.pause();
  latidos.pause();
}

void keyPressed() {
  if ( key == 'k' ) {
    detenerCanciones();
  }
}
