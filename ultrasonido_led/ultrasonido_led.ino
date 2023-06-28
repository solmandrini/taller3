const int Trigger = 2;  //Pin digital 2 para el Trigger del sensor
const int Echo = 3;     //Pin digital 3 para el echo del sensor
int led = 6;            // Pin PWM para el led
int brillo;             // Variable para la intensidad del led

void setup() {
  Serial.begin(9600);          // iniciailzamos la comunicación
  pinMode(Trigger, OUTPUT);    // pin como salida
  pinMode(Echo, INPUT);        // pin como entrada
  digitalWrite(Trigger, LOW);  // Inicializamos el pin con 0
  pinMode(led, OUTPUT);        // Pin como salida
  brillo = 255; // Inicializamos el led en 255 (intensidad máxima)
  digitalWrite(led, brillo);
}

void loop() {

  // put your main code here, to run repeatedly:
  long t;  //timepo que demora en llegar el eco
  long d;  //distancia en centimetros

  digitalWrite(Trigger, HIGH);
  delayMicroseconds(10);  //Enviamos un pulso de 10us
  digitalWrite(Trigger, LOW);

  t = pulseIn(Echo, HIGH);  //obtenemos el ancho del pulso
  d = t / 59;               //escalamos el tiempo a una distancia en cm

  Serial.print("Distancia: ");
  Serial.print(d);  //Enviamos serialmente el valor de la distancia
  Serial.print("cm");
  Serial.println();
  delay(100);  //Hacemos una pausa de 100ms

  // Ciclo for para que baje y suba la intensidad del brillo del led
  for (brillo = 255; brillo >= 0; brillo--) {
    analogWrite(led, brillo);
    delay(15);
  }
  for (brillo = 0; brillo < 256; brillo++) {
    analogWrite(led, brillo);
    delay(15);
  }
}
