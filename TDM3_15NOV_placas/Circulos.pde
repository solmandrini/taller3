
//

class Circulo {

  Gif imagenCirculo;
  PGraphics contenedorCirculo;
  float x, y;
  float nuevaPosX, nuevaPosY;


  float radio;
  float angulo = 0;

  boolean irAlCentro, segundaVuelta;

  Circulo( Gif imagenCirculo, float x, float y, boolean irAlCentro, boolean segundaVuelta) {
    this.imagenCirculo = imagenCirculo;
    this.x = x;
    this.y = y;
    this.irAlCentro = irAlCentro;
    this.segundaVuelta = segundaVuelta;

    radio = min(width, height) * 0.4;

    x = constrain(x, 0, width-200);
    y = constrain(y, 200, height-200);
  }

  Circulo( Gif imagenCirculo, float x, float y, PGraphics contenedorCirculo ) {
    this.imagenCirculo = imagenCirculo;
    this.x = x;
    this.y = y;
    this.contenedorCirculo = contenedorCirculo;
    radio = min(width, height) * 0.4;

    x = constrain(x, 0, width-200);
    y = constrain(y, 200, height-200);
  }

  void dibujarPosicionInicial( ) {
    image( imagenCirculo, x, y);
  }

  void cambiarImagen( Gif imagenNueva ) {
    this.imagenCirculo = imagenNueva;
  }

  void moverCirculosIniciales( String tipoCirculo ) {
    if ( tipoCirculo.equals( "A" )) {
      x -= 2;
      if ( x <= 0 ) {
        x = 0;
        y += 3;
        nuevaPosX = x;
      }
      if (y >= height-200 ) {
        y = height-200;
        nuevaPosY = y;
      }
    } else if ( tipoCirculo.equals( "B" )) {
      y -= 1;
      if ( y <= 0 ) {
        y = 0;
        x -= 2;
        nuevaPosY = y;
      }
      if ( x <= width/2-100 ) {
        x = width/2-100;
        nuevaPosX = x;
      }
    } else if ( tipoCirculo.equals( "C" ) ) {
      x += 5;
      if  ( x >= width - 200 ) {
        x = width - 200;
        y -= 2;
        nuevaPosX = x;
      }
      if ( y <= height/2-100 ) {
        y = height/2-100;
        nuevaPosY = y;
      }
    }
  }

  void moverCirculosCentro( String tipoCirculo) {
    if (tipoCirculo.equals( "A" )) {
      if ( irAlCentro ) {
        x++;
        y--;
        if ( x >= 135 && y <= 265) {
          irAlCentro = false;
        }
      } else if ( !irAlCentro ) {
        x--;
        y++;

        if ( x <= nuevaPosX && y >= nuevaPosY ) {
          x = nuevaPosX;
          y = nuevaPosY;
          segundaVuelta = true;
        }
      }
    } else if (tipoCirculo.equals( "B" )) {
      if ( irAlCentro ) {
        y++;
        if ( y >= 113 ) {
          irAlCentro = false;
        }
      } else if ( !irAlCentro ) {
        y--;

        if ( y <= nuevaPosY ) {
          y = nuevaPosY;
          segundaVuelta = true;
        }
      }
    } else if (tipoCirculo.equals( "C" )) {
      if ( irAlCentro ) {
        x--;
        if ( x <= 455 ) {
          irAlCentro = false;
        }
      } else if ( !irAlCentro ) {
        x++;

        if ( x >= nuevaPosX ) {
          x = nuevaPosX;
          segundaVuelta = true;
        }
      }
    }
  }

  void moverCirculosFinal( String tipoCirculo ) {
    if (tipoCirculo.equals("A")) {
      x += 5;
      if  ( x >= width - 200 ) {
        x = width - 200;
        y -= 2;
        nuevaPosX = x;
      }
      if ( y <= height/2-100 ) {
        y = height/2-100;
        nuevaPosY = y;
      }
    } else if (tipoCirculo.equals("B")) {
      x -= 2;
      if ( x <= 0 ) {
        x = 0;
        y += 3;
        nuevaPosX = x;
      }
      if (y >= height-200 ) {
        y = height-200;
        nuevaPosY = y;
      }
    } else if (tipoCirculo.equals("C")) {
      y -= 1;
      if ( y <= 0 ) {
        y = 0;
        x -= 2;
        nuevaPosY = y;
      }
      if ( x <= width/2-100 ) {
        x = width/2-100;
        nuevaPosX = x;
      }
    }
  }

  void dibujarRaices(Gif imagenRaices, float anguloRotacion, float cambioX, float cambioY) {
    push();
    imageMode(CENTER);
    translate(x, y);
    rotate(radians(anguloRotacion));
    tint(255, 80);
    rect(0, 0, 100, 100);
    pop();
  }

  void dibujarRaicesFinal(Gif imagenRaices, float anguloRotacion, float cambioX, float cambioY) {
    push();
    imageMode(CENTER);
    translate(x, y);
    rotate(radians(anguloRotacion));
    tint(255, 80);
    rect(0, 0, 100, 100);
    pop();
  }
}
