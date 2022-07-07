class Cola {
  PVector pos;
  ArrayList<PVector> art = new ArrayList<PVector>();
  Animacion ani;
  boolean _showCola;
  Cola() {
    pos=new PVector(0, 0, 0);
    for (int i=0; i<10; i++) {
      art.add(new PVector(0, 0, 0));
    }
    ani=new Animacion(3);
    _showCola=false;
  }

  void update() {
    pos.set(cadera.x, cadera.y, cadera.z);
    ani.update();
    if (_showCola!=showCola) {
      _showCola=showCola;
      if (showCola==true) {
        ani.start(1);
      } else {
        ani.start(-1);
      }
    }
  }
  void draw() {
    
    float escalaX=width;
    float escalaY=height;

    float anchoCola=map(pos.z, 8000, 25000, 15, 10);
    float largoCola=map(pos.z, 8000, 25000, 400, 120);

    largoCola*=ani.getPos();
    

    //fill(255, 0, 0);
    float top=pos.y*escalaY+65;
    float left=pos.x*escalaX;
    float sep=largoCola/art.size();
    for (int i=0; i<art.size(); i++) {
      float offset=map(sin(i*0.3+millis()*0.0025), -1, 1, -60, 60);
      float intensidad=map(i, 0, art.size(), 0, 1.2);
      intensidad*=ani.getPos();
      offset*=intensidad;
      float x=left+offset;
      float y=top+i*sep;
      //ellipse(x, y, 5, 5);
      art.get(i).set(x, y);
    }
    stroke(0);
    if (debug) {
      stroke(255, 0, 0);
    }
    strokeWeight(anchoCola);
    for (int i=0; i<art.size()-1; i++) {
      line(art.get(i).x, art.get(i).y, art.get(i+1).x, art.get(i+1).y);
    }

    if (debug) {

      noStroke();
      fill(0);
      String valores=str(pos.z);
      text(valores, 10, 40);
    }

    //if (debug) {
    //  noStroke();
    //  fill(0, 255, 0);
    //  ellipse(pos.x, pos.y, 5, 5);
    //}
  }
}
