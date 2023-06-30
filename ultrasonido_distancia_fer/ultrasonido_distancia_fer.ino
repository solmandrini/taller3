#define trigPin 2
#define echoPin 5
#define led 9


long duracion, distancia;
int limite = 200;  // Medida en vacío del sensor
int intensidad;
bool unaVez = true, unaVez2 = true;


void setup() {
  Serial.begin(9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(led, OUTPUT);
}

void loop() {
  //CALCULAMOS LA DISTANCIA
  digitalWrite(trigPin, LOW);   // Nos aseguramos de que el trigger está desactivado
  delayMicroseconds(2);         // Para asegurarnos de que el trigger esta LOW
  digitalWrite(trigPin, HIGH);  // Activamos el pulso de salida
  delayMicroseconds(10);        // Esperamos 10µs. El pulso sigue active este tiempo
  digitalWrite(trigPin, LOW);   // Cortamos el pulso y a esperar el echo
  duracion = pulseIn(echoPin, HIGH);
  distancia = duracion / 2 / 29.1;


  //DENTRO DEL LIMITE
  if (distancia <= limite) {
    distancia -= 24;
    distancia = distancia < 0 ? 0 : distancia;
    intensidad = 255 / limite * (distancia);
    intensidad = 255 - intensidad;

    analogWrite(led, intensidad);
  }


  delay(50);  // Para limitar el número de mediciones
}