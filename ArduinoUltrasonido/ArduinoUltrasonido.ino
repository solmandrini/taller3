/* Mide la distancia del sonido con el sensor ultrasónico y enciende-apaga la luz Led dependiendo de dicha distancia */

int trigPin = 12; 
int echoPin = 11;
int ledPin = 7;
int duracion;
int distancia;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  digitalWrite(trigPin, HIGH);
  delayMicroseconds( 1 );
  digitalWrite(trigPin, LOW);
  duracion = pulseIn( echoPin, HIGH ); // devuelve un valor de tiempo en microsegundos
  distancia = duracion/58.2; // esto devuelve la distancia en centímetros
  Serial.println( distancia );
  delay( 200 );
  if ( distancia <= 160 && distancia >= 0 ){
    digitalWrite( ledPin, HIGH );
    delay( distancia );
    digitalWrite( ledPin, LOW );
  }
}
