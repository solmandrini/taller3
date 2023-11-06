// al presionar las placas aparece una imagen.+

import processing.serial.*;

Serial puertoSerie;
PImage imagen;  // 

void setup() {
  size(600, 400);  //
  puertoSerie = new Serial(this, "COM3", 9600);  // Cambia "COM3" al puerto serie correcto
  imagen = loadImage("juas.jpg");  // 
}

void draw() {
  if (puertoSerie.available() > 0) {
    String mensaje = puertoSerie.readStringUntil('\n');
    if (mensaje != null) {
      mensaje = mensaje.trim();
      int contador = Integer.parseInt(mensaje);
      
      // Verifica si ambos sensores de presión están activados
      if (contador > 0) {
        // Muestra la imagen solo cuando ambos sensores están activados
        image(imagen, 0, 0, width, height);
      }
    }
  }
}
