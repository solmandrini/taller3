import SimpleOpenNI.*;

SimpleOpenNI kinect;
float circleSize;
int depthMin;
int depthMax;

void setup() {
  size(640, 480);
  
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.enableUser();
  
  circleSize = 50;
  depthMin = Integer.MAX_VALUE;
  depthMax = 2048; // Valor máximo predefinido para mapear la profundidad
}

void draw() {
  // Actualizar la imagen de la cámara
  kinect.update();
  
  // Obtener los píxeles de la imagen RGB
  int[] rgbPixels = kinect.rgbImage().pixels;
  
  // Dibujar la imagen RGB
  loadPixels();
  for (int i = 0; i < rgbPixels.length; i++) {
    pixels[i] = rgbPixels[i];
  }
  updatePixels();
  
  // Obtener el mapa de profundidad
  int[] depthMap = kinect.depthMap();
  
  // Obtener el centro de la imagen
  int centerX = width / 2;
  int centerY = height / 2;
  
  // Obtener la profundidad en el centro de la imagen
  int depthValue = depthMap[centerY * width + centerX];
  
  // Actualizar el valor mínimo de profundidad
  if (depthValue < depthMin) {
    depthMin = depthValue;
  }
  
  // Ajustar el tamaño del círculo en función de la profundidad
  circleSize = map(depthValue, depthMin, depthMax, 10, 100);
  
  // Dibujar el círculo rojo
//  fill(0,100);
//  noStroke();
//  ellipse(centerX, centerY, circleSize, circleSize);
  
  // Mostrar el valor de la profundidad
  fill (0);
  rect (80, 190, 410, 120);
  fill(255);
  textAlign(LEFT, TOP);
  textSize(100);
  text("d: " + depthValue + " mm", 100, 200);
}

