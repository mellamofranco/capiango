//PVector manoIzq;
PVector manoIzq;
PVector codoIzq;
PVector manoDer;
PVector codoDer;
PVector hombro1;
PVector hombro2;

PVector centro;
PVector cadera;
PVector cabeza;

Garra garraIzq;
Garra garraDer;
Cola cola;
Orejas orejas;

boolean showGarraIzq=false;
boolean showGarraDer=false;
boolean showCola=false;
boolean deFrente=false;
boolean showOrejas=false;

void setupPositions() {
  //manoIzq=new PVector(0, 0);
  centro=new PVector(0, 0, 0);
  cadera=new PVector(0, 0, 0);
  manoIzq=new PVector(0, 0, 0);
  codoIzq=new PVector(0, 0, 0);
  manoDer=new PVector(0, 0, 0);
  codoDer=new PVector(0, 0, 0);
  hombro1=new PVector(0, 0, 0);
  hombro2=new PVector(0, 0, 0);
  cabeza=new PVector(0, 0, 0);

  garraIzq=new Garra(IZQ);
  garraDer=new Garra(DER);
  cola= new Cola();
  orejas= new Orejas();
}
void updateOrganos(SkeletonData _s) {
  /// obtener posiciones
  getJointPositions(_s);
  checkShowGato();
}
void checkShowGato() {
  /// ESTA DE FRENTE?
  float difHombros=abs(hombro1.z-hombro2.z);
  deFrente=false;
  if (difHombros<1200) {
    //if (hombro1.x<hombro2.x) {
    deFrente=true;
    //}
  }
  if (debug) {
    textSize(20);
    fill(255, 0, 0);
    if (deFrente) fill(0, 0, 255);
    text(str(hombro1.z), 10, 70);
    text(str(hombro2.z), 10, 90);
    text(str(difHombros), 10, 110);
  }

  if (deFrente) {
    if (manoIzq.y<codoIzq.y) {
      showGarraIzq=true;
    } else {
      showGarraIzq=false;
    }
    if (manoDer.y<codoDer.y) {
      showGarraDer=true;
    } else {
      showGarraDer=false;
    }
    if (showGarraIzq || showGarraDer) {
      showOrejas=true;
      showCola=true;
    } else {
      showOrejas=false;
      showCola=false;
    }
  } else {
    showOrejas=false;
    showCola=false;
    showGarraDer=false;
    showGarraIzq=false;
  }
}

void drawOrganos() {
  if (debug) {
    float escalaX=width;
    float escalaY=height;
    noStroke();
    fill(0, 255, 0);
    int r=10;
    ellipse(cadera.x*escalaX, cadera.y*escalaY, r, r);
    ellipse(centro.x*escalaX, centro.y*escalaY, r, r);
    ellipse(manoIzq.x*escalaX, manoIzq.y*escalaY, r, r);
    ellipse(codoIzq.x*escalaX, codoIzq.y*escalaY, r, r);
    ellipse(manoDer.x*escalaX, manoDer.y*escalaY, r, r);
    ellipse(codoDer.x*escalaX, codoDer.y*escalaY, r, r);
    ellipse(hombro1.x*escalaX, hombro1.y*escalaY, r, r);
    ellipse(hombro2.x*escalaX, hombro2.y*escalaY, r, r);
    ellipse(cabeza.x*escalaX, cabeza.y*escalaY, r, r);
  }




  /// DIBUJAR PARTES DEL CUERPO GATUNO
  garraIzq.update();
  garraIzq.draw();
  garraDer.update();
  garraDer.draw();
  cola.update();
  cola.draw();
  orejas.update();
  orejas.draw();
}

void getJointPositions(SkeletonData _s) {
  centro=getPosicionOrgano(_s, Kinect.NUI_SKELETON_POSITION_SPINE);
  cadera=getPosicionOrgano(_s, Kinect.NUI_SKELETON_POSITION_HIP_CENTER);

  manoIzq=getPosicionOrgano(_s, Kinect.NUI_SKELETON_POSITION_WRIST_LEFT);
  codoIzq=getPosicionOrgano(_s, Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT);

  manoDer=getPosicionOrgano(_s, Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT);
  codoDer=getPosicionOrgano(_s, Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);

  hombro1=getPosicionOrgano(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT);
  hombro2=getPosicionOrgano(_s, Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT);

  cabeza=getPosicionOrgano(_s, Kinect.NUI_SKELETON_POSITION_HEAD);
}

PVector getPosicionOrgano(SkeletonData _s, int organo) {
  PVector respuesta=new PVector(0, 0, 0);
  if (_s.skeletonPositionTrackingState[organo] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED ) {
    respuesta.set(
      _s.skeletonPositions[organo].x, 
      _s.skeletonPositions[organo].y, 
      _s.skeletonPositions[organo].z);
  } 
  return respuesta;
}
float dist2(float x1, float y1, float x2, float y2) {
  return (pow(x2-x1, 2)+pow(y2-y1, 2));
}
float dist3(float x1, float x2) {
  return abs(x2-x1);
}
