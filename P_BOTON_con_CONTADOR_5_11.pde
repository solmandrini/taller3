import processing.serial.*;

Serial puertoSerie;
int contador = 0;

void setup() {
  size(400, 200);
  puertoSerie = new Serial(this, "COM3", 9600);  // Cambia "COM3" al puerto serie correcto
}

void draw() {
  if (puertoSerie.available() > 0) {
    String mensaje = puertoSerie.readStringUntil('\n');
    if (mensaje != null) {
      mensaje = mensaje.trim();
      contador = Integer.parseInt(mensaje);
    }
  }
  
  background(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Contador: " + contador, width/2, height/2);
}
