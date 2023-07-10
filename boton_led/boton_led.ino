int ledPin = 3;
int botonPin = 2;
int estadoBoton;
int anterior;

int prueba = 2;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  pinMode(botonPin, INPUT);
  anterior = digitalRead(botonPin);
}

void loop() {
  // put your main code here, to run repeatedly:
  int estadoBoton = digitalRead(botonPin);
  int estadoLed = digitalRead(ledPin);

  if (anterior == HIGH && estadoBoton == LOW) {
    Serial.print("boton:");
    Serial.println(estadoBoton);
    Serial.print("led:");
    Serial.println(prueba);
    digitalWrite(ledPin, !estadoLed);
    if (digitalRead(ledPin) == LOW) {
    }
  }
  anterior = estadoBoton;
}

/*
  while (digitalRead(botonPin) == LOW) {
    on_off = 0;
  }

  estado = digitalRead(ledPin);
  digitalWrite(ledPin, !estado);

  while (digitalRead(botonPin) == HIGH) {
    on_off = 1;
  }
*/
