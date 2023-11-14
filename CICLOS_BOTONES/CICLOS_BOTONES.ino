const int botonA = 2;
const int botonB = 4;
const int botonC = 7;

unsigned long tiempoAnterior = 0;   // Variable para almacenar el tiempo del último cambio de estado del botón
const long intervaloDebounce = 50;  // Intervalo de debounce en milisegundos

int estadoBotonA = 0;
int estadoBotonB = 0;
int estadoBotonC = 0;

int cicloContador = 0;

boolean estadoAnteriorBA = false;
boolean estadoAnteriorBB = false;
boolean estadoAnteriorBC = false;

boolean tresBotonesPresionados = false;
boolean estadoAnteriorBotones = false;

long tiempoInicio = 0;                    // Para contar el tiempo después de llegar a cicloContador = 2
const unsigned long tiempoEspera = 3000;  // 5000 ms = 5 segundos

void setup() {
  // put your setup code here, to run once:
  pinMode(botonA, INPUT);
  pinMode(botonB, INPUT);
  pinMode(botonC, INPUT);

  Serial.begin(9600);
}

void loop() {
  delay(500);
  estadoBotonA = digitalRead(botonA);
  estadoBotonB = digitalRead(botonB);
  estadoBotonC = digitalRead(botonC);

  boolean estadoActualBotones = (digitalRead(botonA) == HIGH) && (digitalRead(botonB) == HIGH) && (digitalRead(botonC) == HIGH);

  boolean estadoActualBA = (estadoBotonA == HIGH);
  boolean estadoActualBB = (estadoBotonB == HIGH);
  boolean estadoActualBC = (estadoBotonC == HIGH);

  // --- Evalúo cada placa individualmente
  if (estadoActualBA && !estadoAnteriorBA) {
    Serial.println("A");
  }
  if (estadoActualBB && !estadoAnteriorBB) {
    Serial.println("B");
  }
  if (estadoActualBC && !estadoAnteriorBC) {
    Serial.println("C");
  }

  // --- Evalúo los tres botones en simultáneo para dar inicio a la interacción
  if (estadoActualBotones && !estadoAnteriorBotones) {
    tresBotonesPresionados = true;
  }

  if (tresBotonesPresionados == true) {
    //Serial.println("A");
    if (cicloContador < 2) {
      cicloContador++;
    }
    tresBotonesPresionados = false;
  }

  if (cicloContador >= 2) {
    if (tiempoInicio == 0) {
      tiempoInicio = millis();
    }

    if (millis() - tiempoInicio >= tiempoEspera) {  // Si han pasado 5 segundos
      cicloContador = 0;
      tiempoInicio = 0;  // Reiniciar el tiempo de espera
    }
  }

  if (tresBotonesPresionados == true && (millis() - tiempoAnterior) > intervaloDebounce) {
    tresBotonesPresionados = false;
    tiempoAnterior = millis();
    delay(100);
  }

  estadoAnteriorBotones = estadoActualBotones;
  estadoAnteriorBA = estadoActualBA;
  estadoAnteriorBB = estadoActualBB;
  estadoAnteriorBC = estadoActualBC;

  Serial.println(cicloContador);
}
