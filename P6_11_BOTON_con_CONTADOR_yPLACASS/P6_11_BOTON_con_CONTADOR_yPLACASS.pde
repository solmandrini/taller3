// al presionar las placas aparece una imagen.+

import processing.serial.*;

Serial puertoSerie;
PImage imagen;  // 
//int contador;

void setup() {
  size(600, 400);  //
  puertoSerie = new Serial(this, "COM4", 9600);  // Cambia "COM3" al puerto serie correcto

  imagen = loadImage("juas.jpg");  //
}

void draw() {

  if (puertoSerie.available() > 0) {

    String mensaje = puertoSerie.readStringUntil('\n');

    if (mensaje != null) {
      mensaje = mensaje.trim();

      int contador = Integer.parseInt(mensaje);

      // String[] valores = mensaje.trim().split(",");

      //  if (valores.length == 2) {
      //  int lecturaBoton = int(valores[0]);
      //int lecturaBoton2 = int(valores[1]);

      //  println("lecturaBoton: " + lecturaBoton + ", lecturaBoton2: " + lecturaBoton2);
      //  println("- " + mensaje);
      // }

      if (mensaje.equals("1")) {

        // Dibuja un círculo azul cuando se presiona botonPin
        fill (random(0, 255), 255, 0);
        noStroke();
        ellipse(0, 0, 50, 50);
        println("botonPin(A0): " + mensaje);
      } else if (mensaje.equals("2")) {

        // Dibuja un círculo rojo cuando se presiona botonPin2
        noStroke();
        fill (random(0, 255), 100, 50);
        ellipse(width/2+1, height/2, 50, 50);
        println("botonPin2(A1):" + mensaje);
      }

      // Verifica si ambos sensores de presión están activados
      if (contador > 10) {
        //  // Muestra la imagen solo cuando ambos sensores están activados
        image(imagen, 300, 0, 100, 50);
        println ("contador:"+ contador);
      }
    }
  }
}
