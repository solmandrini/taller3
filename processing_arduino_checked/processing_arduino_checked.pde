// --- 08/07: Prueba processing y arduino

import processing.sound.*;

SoundFile fondo, baseTambor, baseSuspenso, sintetizadores, combate, latidos;

import processing.serial.*;
Serial puerto; // Serial port

// --- Datos para rellenar el círculo
float value;
color relleno;

// --- Sonidos


void setup() {
  size( 800, 800 );

  String nombrePuerto = Serial.list()[0]; // Guardo en una variable el puerto disponible
  puerto = new Serial(this, nombrePuerto, 9600); // Abro el puerto especificado arriba
  puerto.bufferUntil('\n'); // Establece un byte específico en el búfer hasta antes de llamar

  // --- Sonidos --- 
  fondo = new SoundFile (this, "BaseFondo.wav");
  baseTambor = new SoundFile (this, "BaseTambores.wav");
  baseSuspenso = new SoundFile (this, "BaseSuspenso.wav");
  sintetizadores = new SoundFile (this, "Sintetizadores.wav");
  combate = new SoundFile (this, "Combate.wav");
  latidos = new SoundFile (this, "Latidos.wav");

  fondo.loop();
  fondo.play();
  fondo.amp(0.03);

  relleno = color(0, 0, 0);
}

void draw() {
  fill(relleno);
  ellipse(width/2, height/2, value, value);
  if ( value > 500 ) {
    relleno = color(random(255), random(255), random(255));
  }


  float amp = map(value, 0, 2000, 1, -1);

  println("Valor: " + value + "Amp: " + amp);
  fondo.amp(amp);
}


void serialEvent (Serial puerto) { // Metodo para leer los datos desde arduino
  String inString = puerto.readStringUntil('\n'); // Leo los Strings y los almaceno en la variable
  value = float(inString); // Convierto la variable en un dato numérico
}
