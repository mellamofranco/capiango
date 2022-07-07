int IZQ=0;
int DER=1;
class Garra {
  boolean showGarra;
  Animacion ani;
  int lado;
  PVector mano;
  PVector codo;
  float distMax;

  Garra(int _lado) {
    lado=_lado;
    distMax=0.16;
    //if (lado==DER) distMax*=-1;
    showGarra=false;

    ani=new Animacion(5);
    mano=new PVector(0, 0, 0);
    codo=new PVector(0, 0, 0);
  }
  void update() {
    float dis=0;
    if (lado==IZQ) {
      dis=centro.x-manoIzq.x;
    } else {
      dis=manoDer.x-centro.x;
    }


    /// CONDICION PARA MOSTRAR/OCULTAR GARRA
    //if (dis>distMax) {
    //  if (!showGarra) {
    //    showGarra=true;
    //    ani.start(1);
    //  }
    //} else {
    //  if (showGarra) {
    //    showGarra=false;
    //    ani.start(-1);
    //  }
    //}
    boolean _showGarra=showGarraIzq;
    if (lado==DER) _showGarra=showGarraDer;
    if (showGarra!=_showGarra) {
      showGarra=_showGarra;
      if (showGarra==true) {
        ani.start(1);
      } else {
        ani.start(-1);
      }

      /// SONIDO
      if (showGarra) {
        if (lado==IZQ) {
          sonido_garra_izq.play();
        } else {
          sonido_garra_der.play();
        }
      }
    }

    /// update counter animacion
    ani.update();


    if (lado==IZQ) {
      /// GARRA IZQUIERDA
      mano.set(manoIzq.x, manoIzq.y, manoIzq.z);
      codo.set(codoIzq.x, codoIzq.y, codoIzq.z);
    } else {
      /// GARRA DERECHA
      mano.set(manoDer.x, manoDer.y, manoDer.z);
      codo.set(codoDer.x, codoDer.y, codoDer.z);
    }

    /// debug
    if (debug) {
      if (lado==IZQ) {
        fill(0);
        String valores=str(manoIzq.z);
        text(valores, 10, 20);
      }
    }
  }
  void draw() {
    float escalaX=width;
    float escalaY=height;

    pushMatrix();

    translate(mano.x*escalaX, mano.y*escalaY);
    float angle=getAngle(mano.x, mano.y, codo.x, codo.y);
    rotate(angle+PI*-0.5);

    /// escala garra segun pos en Z de la manoeca 
    float posZ=map(mano.z, 8000, 25000, 1.15, 0.95);
    float w=25*posZ;
    float h=w*4;
    float x=w*-0.5;
    float y=h*-0.0;
    float tamanoGarra=h*ani.getPos();
    image(imgGarra, x, (y-tamanoGarra), w, tamanoGarra);

    /// rect debug
    //noFill();
    //stroke(255, 0, 0);
    //rect(x, y, w, h);

    popMatrix();


    /// dibujar joints
    if (debug) {
      if (showGarra) {
        fill(255, 0, 0);
        stroke(255, 0, 0);
      } else {
        fill(0, 255, 0);
        stroke(0, 255, 0);
      }
      //circle(mano.x*escalaX, mano.y*escalaY, 5);
      //circle(codo.x*escalaX, codo.y*escalaY, 5);
      strokeWeight(2);
      line(codo.x*escalaX, codo.y*escalaY, mano.x*escalaX, mano.y*escalaY);
      strokeWeight(1);
    }
  }
}

float getAngle(float x1, float y1, float x2, float y2) {
  //return atan2(y2 - y1, x2 - x1)* 180/ PI;
  return atan2(y2 - y1, x2 - x1);
}
