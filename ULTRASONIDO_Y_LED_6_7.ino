// MEZCLA DE HOY (6/7) CON EL CODIGO DE CHATGPT PARA ULTRASONIDO

#define LED_PIN 9
#define TRIGGER_PIN 6   // Pin del sensor de ultrasonido conectado al pin TRIGGER
#define ECHO_PIN 7      // Pin del sensor de ultrasonido conectado al pin ECHO

void setup() {

  pinMode(TRIGGER_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode (LED_PIN, OUTPUT);

  Serial.begin (9600);
}

void loop() {

  long duracion, distancia;

  // Envía un pulso de 10μs al sensor de ultrasonido
  digitalWrite(TRIGGER_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIGGER_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIGGER_PIN, LOW);

  // Lee el tiempo que tarda el eco en regresar
  duracion = pulseIn(ECHO_PIN, HIGH);

  // Calcula la distancia en centímetros
  distancia = duracion * 0.034 / 2;

  // Mapea la distancia a un rango adecuado para el brillo del LED (0-255)
 int brightness = map(distancia, 5, 100, 0, 255); // Intercambiamos los valores máximo y mínimo

  // Limita los valores del brillo dentro del rango 0-255
  brightness = constrain(brightness, 0, 255);
//if (distancia > 50) {


//}
  // Establece el brillo del LED
  analogWrite(LED_PIN, brightness);

  Serial.println(distancia);
  delay(100); // Pequeño retraso para estabilizar las lecturas del sensor

  //float animacion;
   
   //animacion = int ( float (cos(millis()/1000.0) * .5 + .5) * 255);

   //Serial.println(animacion);

   //analogWrite (LED_PIN, animacion);

}