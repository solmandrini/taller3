int led = 2;
int boton = 3;
int estado = 0;
bool estadoBoton;

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
  pinMode(boton, INPUT);
}

void loop() {
  estadoBoton = digitalRead(boton);
  if( estadoBoton == HIGH ){
    estado = 1;
  } 
  if( estado == 1 ){
    digitalWrite(led, HIGH);
  }
}
