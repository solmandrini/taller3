//6-11 Placas de presión (2) con contador en millis. Funciona bien!

const int botonPin = A0;  // Pin del sensor de presión conectado a Arduino (entrada analógica)
const int botonPin2 = A1;  // Pin del segundo sensor de presión conectado a Arduino (entrada analógica)
const int ledPin = 13;    // Pin del LED conectado a Arduino
int contador = 0;         // Variable para contar las veces que se presiona el botón
int umbralPresion = 100;  // Umbral para detectar una pulsación, ajusta según sea necesario
unsigned long tiempoAnterior = 0; // Variable para almacenar el tiempo del último cambio de estado del botón
const long intervaloDebounce = 50; // Intervalo de debounce en milisegundos

void setup() {
  pinMode(botonPin, INPUT);
  pinMode(botonPin2, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int lecturaBoton = analogRead(botonPin);
  int lecturaBoton2 = analogRead(botonPin2);

  if (lecturaBoton > umbralPresion && lecturaBoton2 > umbralPresion) {
    // Detecta una pulsación si la lectura está por encima del umbral
    if ((millis() - tiempoAnterior) > intervaloDebounce) {
      tiempoAnterior = millis();
      contador++;
      Serial.println(contador);  // Envía el contador a través del puerto serie
      digitalWrite(ledPin, HIGH);
      delay(200);  // Pequeño retardo para visualizar la pulsación del botón
      digitalWrite(ledPin, LOW);
    }
  }
}
