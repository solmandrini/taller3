import processing.serial.*;
Serial puertoSerie;

int contador;
int ciclo;

boolean condicionDeCambio = false;
void setup() {

  size(600, 400);  //
  puertoSerie = new Serial(this, "COM3", 9600);
  ciclo = 0;
}

void draw() {
  background(255);

  if (puertoSerie.available() > 0) {

    String mensaje = puertoSerie.readStringUntil('\n');

    if (mensaje != null) {
      mensaje = mensaje.trim();

      if (esNumero(mensaje)) {
        // -- Si es un número, lo guarda en la variable contador"
        int contador = Integer.parseInt(mensaje);
      } else {
        println("String recibido: " + mensaje);
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

  cambioDeCiclo();
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

// Esto no es tan importante, es para ver en pantalla los cambios cuando el ciclo aumenta
void cambioDeCiclo() {
  if ( ciclo == 1 ) {
    background(#FFEE98);
    push();
    textAlign(CENTER);
    textSize(16);
    fill(0);
    text("CICLO 1", width/2, height/2);
    pop();
  }
  if ( ciclo == 2 ) {
    background(#AAFF98);
    push();
    textAlign(CENTER);
    textSize(16);
    fill(0);
    text("CICLO 2", width/2, height/2);
    pop();
  }
  if ( ciclo == 3 ) {
    background(#FF98F8);
    push();
    textAlign(CENTER);
    textSize(16);
    fill(0);
    text("CICLO 3", width/2, height/2);
    pop();
  }
  if ( ciclo == 4 ) {
    background(#98BEFF);
    push();
    textAlign(CENTER);
    textSize(16);
    fill(0);
    text("CICLO 4", width/2, height/2);

    pop();
  }
  if ( ciclo == 5 ) {
    background(#FF98B4);
    push();
    textAlign(CENTER);
    textSize(16);
    fill(0);
    text("CICLO 5", width/2, height/2);
    pop();
  }
}
