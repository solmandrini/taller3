
// Declaramos los pines de Arduino de cada botón
const int buttonLeft = 7;
const int buttonRight = 11;

const int ledPin = 13;

void setup() {
  Serial.begin(9600); // Incializamos el puerto Serial
  while(!Serial){
    ; // Esperamos a que el puerto abra
  }

  // Iniciamos cada Pin
  pinMode(buttonLeft, INPUT);
  pinMode(buttonRight, INPUT);

  pinMode(ledPin, OUTPUT);
 digitalWrite(ledPin, HIGH);
}

void loop() {
  
  if(isButtonPressed( buttonLeft )){
    Serial.print("L,");
  }

  if(isButtonPressed( buttonRight )){
    Serial.print("R,");
  }
  // Serial.println('_');
}

bool isButtonPressed(int button) {
  return digitalRead(button) == HIGH; // DEVUELVE VERDADERO SI EL BOTON ESTÁ PRESIONADO  
}
