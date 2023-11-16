// TALLER 3 - CONTROL TECLADO (FINAL)

import gifAnimation.*;
import processing.serial.*;

Serial myPort;
String val;

Circulo circuloA, circuloB, circuloC;

Gif raicesBlancas, raicesVerdes, raicesVerdesGlitch, raicesVerdesGlitchFinal,
  imagenRaices;

PGraphics pgCirculoA;

String estado = "Cero";
String placaPresionada = " ";
String placaAnteriorPresionada = " ";

boolean hayRaices = false;
boolean isPortAvailable = true;

int contador;
int ciclo;

boolean condicionDeCambio = false;

void setup() {
  size( 800, 600, P3D );

  cargarGifs();
  circuloA = new Circulo( raicesBlancas, width/2-100, 0, true, false);
  circuloB = new Circulo( raicesBlancas, width-200, height/2-100, true, false );
  circuloC = new Circulo( raicesBlancas, 0, height-200, true, false );

  if ( isPortAvailable ) {
    String portName = Serial.list()[0];
    myPort = new Serial(this, portName, 9600);
  }
}

void draw() {
  background(0);

  if (myPort.available() > 0) {

    String mensaje = myPort.readStringUntil('\n');

    if (mensaje != null) {
      mensaje = mensaje.trim();

      if (esNumero(mensaje)) {
        // -- Si es un número, lo guarda en la variable contador"
        int contador = Integer.parseInt(mensaje);
      } else {

        if (mensaje.equals("A")) {
          println("String recibido: " + mensaje);
          if (estado.equals("Cero")) {
            circuloA.cambiarImagen(raicesVerdes);
          }
        }
        if (mensaje.equals("B")) {
          println("String recibido: " + mensaje);
          if (estado.equals("Cero")) {
            circuloB.cambiarImagen(raicesVerdes);
          }
        }
        if (mensaje.equals("C")) {
          println("String recibido: " + mensaje);
          if (estado.equals("Cero")) {
            circuloC.cambiarImagen(raicesVerdes);
          }
        }
        if (mensaje.equals("D")) {
          if (estado.equals("Cero")) {
            circuloA.cambiarImagen(raicesBlancas);
            circuloB.cambiarImagen(raicesBlancas);
            circuloC.cambiarImagen(raicesBlancas);
            circuloA.moverCirculosIniciales( "A" );
            circuloB.moverCirculosIniciales( "B" );
            circuloC.moverCirculosIniciales( "C" );

            estado = "Inicio";
          }
        }
        // Guardar en la variable correspondiente
      }

      if ( contador == 0 ) {
        condicionDeCambio = false;
      }

      if (contador >= 2 && !condicionDeCambio) {
        // Si el contador (num. que recibe desde Arduino) es >= 2, y la Condicion d Cambio es falsa, el ciclo aumenta en 1.
        // El contador aumenta cada vez que se detecta que las tres placas están siendo presionadas. El num "2" lo tenemos que acomodar d acuerdo a los pasos del ritual
        ciclo += 1;
        condicionDeCambio = true;
      }
    }
  }

  if ( isPortAvailable ) {
    if ( mousePressed == true ) {
      myPort.write('1');
      println("1");
    } else {
      myPort.write('0');
    }
  }

  circuloA.dibujarPosicionInicial( );
  circuloB.dibujarPosicionInicial( );
  circuloC.dibujarPosicionInicial( );


  if ( estado.equals("Inicio") ) {
    circuloA.cambiarImagen(raicesBlancas);
    circuloB.cambiarImagen(raicesBlancas);
    circuloC.cambiarImagen(raicesBlancas);
    circuloA.moverCirculosIniciales( "A" );
    circuloB.moverCirculosIniciales( "B" );
    circuloC.moverCirculosIniciales( "C" );

    if ( hayRaices ) {
      circuloA.dibujarRaices(imagenRaices, 10, 270, -100);
      circuloB.dibujarRaices(imagenRaices, -200, 80, -300);
      circuloC.dibujarRaices(imagenRaices, -90, -0, -0);
    }
  } else if ( estado.equals("Centro") ) {
    circuloA.moverCirculosCentro("A");
    circuloB.moverCirculosCentro("B");
    circuloC.moverCirculosCentro("C");
  } else if ( estado.equals("Segunda vuelta") ) {
    circuloA.moverCirculosFinal("A");
    circuloB.moverCirculosFinal("B");
    circuloC.moverCirculosFinal("C");
  }
}

// -- Método que devuelve verdadero si está leyendo un número
boolean esNumero(String str) {
  for (int i = 0; i < str.length(); i++) {
    if (!Character.isDigit(str.charAt(i))) {
      return false;
    }
  }
  return true;
}

void keyPressed() {
  // Estado cero: la interacción todavía no se inició. Se está evaluando qué placas fueron presionadas
  if ( estado.equals("Cero") ) {
    if ( placaPresionada.equals(" ") ) {
      if ( key == 'A' || key == 'a' ) {
        placaPresionada = "A";
        placaAnteriorPresionada = placaPresionada;
        circuloA.cambiarImagen(raicesVerdes);
      } else if ( key == 'B' || key == 'b' ) {
        placaPresionada = "B";
        placaAnteriorPresionada = placaPresionada;
        circuloB.cambiarImagen(raicesVerdes);
      } else if ( key == 'C' || key == 'c' ) {
        placaPresionada = "C";
        placaAnteriorPresionada = placaPresionada;
        circuloC.cambiarImagen(raicesVerdes);
      }
    }

    if (placaAnteriorPresionada.equals( "A" )) {
      if ( key == 'B' || key == 'b' ) {
        placaPresionada = "AB";
        placaAnteriorPresionada = placaPresionada;
        circuloB.cambiarImagen(raicesVerdes);
      } else if ( key == 'C' || key == 'c' ) {
        placaPresionada = "AC";
        placaAnteriorPresionada = placaPresionada;
        circuloC.cambiarImagen(raicesVerdes);
      }
    } else if (placaAnteriorPresionada.equals( "B" )) {
      if ( key == 'A' || key == 'a' ) {
        placaPresionada = "BA";
        placaAnteriorPresionada = placaPresionada;
        circuloA.cambiarImagen(raicesVerdes);
      } else if ( key == 'C' || key == 'c' ) {
        placaPresionada = "BC";
        placaAnteriorPresionada = placaPresionada;
        circuloC.cambiarImagen(raicesVerdes);
      }
    } else if (placaAnteriorPresionada.equals( "C" ) ) {
      if ( key == 'A' || key == 'a' ) {
        placaPresionada = "CA";
        placaAnteriorPresionada = placaPresionada;
        circuloA.cambiarImagen(raicesVerdes);
      } else if ( key == 'B' || key == 'b' ) {
        placaPresionada = "CB";
        placaAnteriorPresionada = placaPresionada;
        circuloB.cambiarImagen(raicesVerdes);
      }
    }

    if (placaPresionada.equals( "AB" ) || placaPresionada.equals( "AC" )) {
      if ( key == 'C' || key == 'c' ) {
        circuloC.cambiarImagen(raicesVerdes);
      } else if ( key == 'B' || key == 'b' ) {
        circuloB.cambiarImagen(raicesVerdes);
      }
      placaAnteriorPresionada = "ABC";
    } else if (placaPresionada.equals( "BA" ) || placaPresionada.equals( "BC" )) {
      if ( key == 'C' || key == 'c' ) {
        circuloC.cambiarImagen(raicesVerdes);
      } else if ( key == 'A' || key == 'a' ) {
        circuloA.cambiarImagen(raicesVerdes);
      }
      placaAnteriorPresionada = "ABC";
    } else if (placaPresionada.equals( "CA" ) || placaPresionada.equals( "CB" )) {
      if ( key == 'B' || key == 'b' ) {
        circuloB.cambiarImagen(raicesVerdes);
      } else if ( key == 'A' || key == 'a' ) {
        circuloA.cambiarImagen(raicesVerdes);
      }
      placaAnteriorPresionada = "ABC";
    }

    // En caso de que haya que glitchear
    if ( key == '1' ) {
      circuloA.cambiarImagen(raicesVerdesGlitch);
      placaPresionada = " ";
    }
    if ( key == '2' ) {
      circuloB.cambiarImagen(raicesVerdesGlitch);
      placaPresionada = " ";
    }
    if ( key == '3' ) {
      circuloC.cambiarImagen(raicesVerdesGlitch);
      placaPresionada = " ";
    }

    if ( key ==  ENTER ) {
      estado = "Inicio";
    }
  } else if ( estado.equals("Inicio")) {
    circuloA.dibujarPosicionInicial( );
    circuloB.dibujarPosicionInicial( );
    circuloC.dibujarPosicionInicial( );

    if ( key == '1' ) {
      circuloA.cambiarImagen( raicesVerdesGlitchFinal );
    } else if ( key == '2' ) {
      circuloB.cambiarImagen( raicesVerdesGlitchFinal );
    } else if ( key == '3' ) {
      circuloC.cambiarImagen( raicesVerdesGlitchFinal );
    }

    if ( key == 'A' || key == 'a' ) {
      circuloA.cambiarImagen( raicesVerdes );
    } else if ( key == 'B' || key == 'b' ) {
      circuloB.cambiarImagen( raicesVerdes );
    } else if ( key == 'C' || key == 'c' ) {
      circuloC.cambiarImagen( raicesVerdes );
    }
    if ( key == 'r' || key == 'R'  ) {
      hayRaices = true;
    }
    if ( key ==  ENTER ) {
      estado = "Centro";
      hayRaices = false;
    }
  } else if ( estado.equals("Centro")) {
    circuloA.dibujarPosicionInicial( );
    circuloB.dibujarPosicionInicial( );
    circuloC.dibujarPosicionInicial( );

    if ( key == ENTER ) {
      estado = "Segunda vuelta";
    }
  } else if (estado.equals("Segunda vuelta")) {
    circuloA.dibujarPosicionInicial( );
    circuloB.dibujarPosicionInicial( );
    circuloC.dibujarPosicionInicial( );

    if ( key == ENTER ) {
      estado = "Final";
      hayRaices = true;
    }
  } else if (estado.equals("Final")) {
    if ( key == '0' ) {
      estado = "Cero";
      placaPresionada = " ";
      placaAnteriorPresionada = " ";
      hayRaices = false;

      println("Reinicio");
    }
  }
}

void cargarGifs() {
  raicesBlancas = new Gif(this, "circulo2.gif");
  raicesBlancas.play();

  raicesVerdes = new Gif(this, "circulo4.gif");
  raicesVerdes.play();

  raicesVerdesGlitch = new Gif(this, "Circulo5.gif");
  raicesVerdesGlitch.play();

  raicesVerdesGlitchFinal = new Gif(this, "Circulo6.gif");
  raicesVerdesGlitchFinal.play();

  imagenRaices = new Gif(this, "raiz_centro.gif" );
  imagenRaices.play();
}
