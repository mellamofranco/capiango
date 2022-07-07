import processing.sound.*;

import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;


Kinect kinect;
ArrayList <SkeletonData> bodies;

boolean debug=true;

SoundFile sonido_garra_izq;
SoundFile sonido_garra_der;
PImage img;
boolean fullscreen=false;


//Animacion ani1;
void setup()
{
  //size(640, 480, P3D);

  size(640, 480);
  //fullScreen();

  background(0);

  kinect = new Kinect(this);
  smooth();
  frameRate(30);
  bodies = new ArrayList<SkeletonData>();

  setupImagenes();
  setupPositions();
  setupImagenes();

  //ani1=new Animacion();

  sonido_garra_izq = new SoundFile(this, "assets/garra_izq.mp3");
  sonido_garra_der = new SoundFile(this, "assets/garra_der.mp3");
  img = loadImage("assets/fondo.png"); // Load the original image;
}

void draw()
{
  background(255);
  image(img, 0, 0, width, height);
  //img.resize(640, 480);

  //image(kinect.GetDepth(), 320, 240, 320, 240);
  //tint(0, 153, 204);

  //image(kinect.GetMask(), 0, 0, 320, 240);
  image(kinect.GetMask(), 0, 0, width, height);
  filter(ERODE);
  //filter(POSTERIZE, 4);
  filter(THRESHOLD, 1);
  //filter(BLUR,1.5);

  //image(kinect.GetImage(), 320, 0, 320, 240);


  for (int i=0; i<bodies.size (); i++)
  {
    if (debug) {
      //drawSkeleton(bodies.get(i));
    }
    //drawPosition(bodies.get(i));
    updateOrganos(bodies.get(i));
    if (centro.x!=0) {
      drawOrganos();
      break;
    }




    /// ATENCION: SOLO FUNCIONA PARA 1 BODY !!!!!
    /// (por eso salgo del for, si hay mas de uno no lo proceso)
    //if (i>0) break;
  }


  //if (bodies.size()>0) {
  //  updateOrganos(bodies.get(bodies.size()-1));
  //  drawOrganos();
  //}



  //filter(BLUR, 2);

  //cola.update();
  //cola.draw();

  /// test animacion
  //ani1.update();
  //fill(0,255,100);
  //float ancho=ani1.getPos();
  //rect(0,0,ancho*100,30);
  //text(str(ancho),10,40);
}

//void drawPosition(SkeletonData _s) 
//{
//  noStroke();
//  fill(0, 100, 255);
//  String s1 = str(_s.dwTrackingID);
//  text(s1, _s.position.x*width/2, _s.position.y*height/2);
//}

void drawSkeleton(SkeletonData _s) 
{
  strokeWeight(1);
  // Body
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HEAD, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
    Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
    Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SPINE, 
    Kinect.NUI_SKELETON_POSITION_HIP_CENTER);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
    Kinect.NUI_SKELETON_POSITION_HIP_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
    Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
    Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);

  // Left Arm
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, 
    Kinect.NUI_SKELETON_POSITION_WRIST_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, 
    Kinect.NUI_SKELETON_POSITION_HAND_LEFT);

  // Right Arm
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);

  // Left Leg
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
    Kinect.NUI_SKELETON_POSITION_KNEE_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_KNEE_LEFT, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT, 
    Kinect.NUI_SKELETON_POSITION_FOOT_LEFT);

  // Right Leg
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_FOOT_RIGHT);
}

void DrawBone(SkeletonData _s, int _j1, int _j2) 
{

  noFill();
  stroke(255, 255, 0);

  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width, 
      _s.skeletonPositions[_j1].y*height, 
      _s.skeletonPositions[_j2].x*width, 
      _s.skeletonPositions[_j2].y*height);
  }
}


void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}

void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}

//int test=-1;
//void mouseClicked() {
//  if (test==1) {
//    test=-1;
//  } else {
//    test=1;
//  }

//  ani1.start(test);
//}

void keyPressed() {
  if (key == 'd' || key=='D') {
    debug=!debug;
  }
  if (key=='f') {
    if (fullscreen == false) {
      fullscreen = true;
      surface.setSize(displayWidth, displayHeight);
      surface.setLocation(-8, -31);
      surface.setAlwaysOnTop(true);
    } else {
      fullscreen = false;
      surface.setSize(640, 480);
      surface.setLocation(10, 10);
      surface.setAlwaysOnTop(false);
    }
  }
}
