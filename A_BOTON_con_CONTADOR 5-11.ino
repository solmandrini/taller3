const int botonPin = 5;  // Pin del botón conectado a Arduino
const int ledPin = 13;    // Pin del LED conectado a Arduino
int contador = 0;         // Variable para contar las veces que se presiona el botón
int estadoBotonAnterior = LOW; // Variable para almacenar el estado anterior del botón

void setup() {
  pinMode(botonPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);

}

void loop() {
  int estadoBoton = digitalRead(botonPin);

  // Detecta el flanco ascendente (cuando el botón pasa de LOW a HIGH)
  if (estadoBoton == HIGH && estadoBotonAnterior == LOW) {
    digitalWrite(ledPin, HIGH);
    contador++;
    Serial.println(contador);  // Envía el contador a través del puerto serie
  } else {
    digitalWrite(ledPin, LOW);
  }

  estadoBotonAnterior = estadoBoton; // Almacena el estado actual del botón para la próxima iteración
}
