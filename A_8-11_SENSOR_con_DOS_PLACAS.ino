//6-11 Placas de presión (2) con contador en millis. Funciona bien!

const int botonPin = A0;            // Pin del sensor de presión conectado a Arduino (entrada analógica)
const int botonPin2 = A1;           // Pin del segundo sensor de presión conectado a Arduino (entrada analógica)
const int ledPin = 13;              // Pin del LED conectado a Arduino
int contador = 10;                  // Variable para contar las veces que se presiona el botón
int umbralPresion = 100;            // Umbral para detectar una pulsación, ajusta según sea necesario
unsigned long tiempoAnterior = 0;   // Variable para almacenar el tiempo del último cambio de estado del botón
const long intervaloDebounce = 50;  // Intervalo de debounce en milisegundos
boolean boton1Presionado = false;
boolean boton2Presionado = false;

void setup() {
  pinMode(botonPin, INPUT);
  pinMode(botonPin2, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}
//
void loop() {
  delay(500);
  int lecturaBoton = analogRead(botonPin);
  int lecturaBoton2 = analogRead(botonPin2);

  if (lecturaBoton > umbralPresion && !boton1Presionado) {
    // Envía un mensaje cuando botonPin es presionado

    delay(200);  // retardo para evitar enviar múltiples mensajes por una única pulsación
    boton1Presionado = true;
    Serial.println("1");
    delay(100);
    //boton1Presionado = false;
    //boton2Presionado = false; // Reinicia el estado del otro botón
  
  } else if (lecturaBoton2 > umbralPresion && !boton2Presionado) {
    // Envía un mensaje cuando botonPin2 es presionado

    delay(200);  //  retardo para evitar enviar múltiples mensajes por una única pulsación
    boton2Presionado = true;
    Serial.println("2");
    delay(100);
   // boton2Presionado = false;
  // boton1Presionado = false; // Reinicia el estado del otro botón
  }  
  if (boton1Presionado == true && boton2Presionado == true && (millis() - tiempoAnterior) > intervaloDebounce) {
    //if (lecturaBoton > umbralPresion && lecturaBoton2 > umbralPresion) {
    // Detecta una pulsación si la lectura está por encima del umbral
    // if ((millis() - tiempoAnterior) > intervaloDebounce) {
     boton2Presionado = false;
    boton1Presionado = false;
    tiempoAnterior = millis();
    contador++;
    //Serial.println(contador);  // Envía el contador a través del puerto serie
    // Serial.println(String(contador));
    Serial.println(contador);
    digitalWrite(ledPin, HIGH);
    delay(200);  //  retardo para visualizar la pulsación del botón
    digitalWrite(ledPin, LOW);
    //}
  }
}
