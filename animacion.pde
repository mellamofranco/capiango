class Animacion {
  int counter;
  int step;
  boolean working;
  Animacion(int _step) {
    step=_step;
    counter=0;
  }
  void start(int _dir) {
    if (_dir==1) {
      counter=0;
      step=abs(step);
    } else {
      counter=100;
      step=abs(step)*-1;
    }
    working=true;
  }
  void update() {
    if (working) {
      counter+=step;
      if (counter>=100) {
        counter=100;
        working=false;
      } 
      if (counter<=0) {
        counter=0;
        working=false;
      }
    }
  }
  float getPos() {
    //return counter;
    float pos;
    if (step>0) {
      pos=easeOut(counter*0.01);
    } else {
      pos=easeIn(counter*0.01);
    }
    return pos;
  }
}
float easeOut(float x) {
  /// easeOutQuint
  return 1 - pow(1 - x, 5);
}
float easeIn(float x) {
  /// easeInQuint
  return x * x * x * x * x;
}
