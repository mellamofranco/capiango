class Orejas {
  PVector pos;
  ArrayList<PVector> art = new ArrayList<PVector>();
  Animacion ani;
  boolean _showOrejas;
  Orejas() {
    pos=new PVector(0, 0, 0);
    ani=new Animacion(5);
    _showOrejas=false;
  }

  void update() {
    pos.set(cabeza.x, cabeza.y, cabeza.z);
    ani.update();
    if (_showOrejas!=showOrejas) {
      _showOrejas=showOrejas;
      if (showOrejas==true) {
        ani.start(1);
      } else {
        ani.start(-1);
      }
    }
  }
  void draw() {
    float escalaX=width;
    float escalaY=height;


    float escalaCabeza=map(cabeza.z, 8000, 25000, 1.05, 0.5);
    float w=120 * escalaCabeza * ani.getPos();
    float h=w;

    float x=pos.x*escalaX;
    float y=pos.y*escalaY - h*0.125;



    imageMode(CENTER);
    image(imgOrejas, x, y, w, h);
    imageMode(CORNER);
    if (debug) {
      noStroke();
      fill(255, 0, 255);
      ellipse(x, y, 10, 10);

      fill(255, 0, 255);
      text(escalaCabeza, 10, 130);
    }
  }
}
