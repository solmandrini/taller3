import processing.serial.*;

Serial myPort; 
String val;

void setup(){
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600); // 9600 = vel. de envío de datos
}

void draw(){
  if( myPort.available() > 0 ){
    val = myPort.readStringUntil('\n');
  }
  println(val);
}
