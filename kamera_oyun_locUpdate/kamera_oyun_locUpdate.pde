import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
int derinlik=1200;
stick s1, s2;
ball b;
int [][] carpma = new int[2][3];
int camX, camY ;
int score1=0, score2=0;
boolean bekle=true;
String message="";
long time=millis();

void setup() { 
 size(displayWidth, displayHeight, P3D);
/*  surface.setResizable(true);

  if (displayHeight<800)
    surface.setSize(640, 480);
*/
//size(800, 600, P3D);
  smooth();
  camX= width/2;
  camY = height/2;
derinlik=width;
  s1= new stick(0, color(255, 200, 200, 200));
  s2= new stick(-derinlik, color(200, 200, 255, 200));
  b= new ball();

  for (int i=0; i<2; i++)
    for (int j=0; j<3; j++)
      carpma[i][j]=-50000;

  video = new Capture(this, 320, 240);
  opencv = new OpenCV(this, 320, 240);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();

}

void draw() {
  opencv.loadImage(video);
  Rectangle[] faces = opencv.detect();

  if (faces.length>0) {  
    int yeniX =(faces[0].x+faces[0].width/2)*width/video.width;
    int yeniY =(faces[0].y+faces[0].height/3)*height/video.height;
    if (sqrt(pow(camX-yeniX, 2)+pow(camY-yeniY, 2))>5) {
      camX=yeniX;
      camY=yeniY;
    }
  }

  background(0);
  lights();

/*
  beginCamera();
  camera(width-camX, camY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
//  camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);

  endCamera();
*/


  pushMatrix();
  fill(s1.c);
  textSize(80);
  translate(getX(50,-derinlik/2), getY(height/2-80,-derinlik/2), -derinlik/2);
  text(score1, 0, 0);
  popMatrix();

  pushMatrix();
  fill(s2.c);
  textSize(80);
  translate(getX(50,-derinlik/2), getY(height/2+20,-derinlik/2), -derinlik/2);
  text(score2, 0, 0);
  popMatrix();

  if (millis()-time<3000) {
    pushMatrix();
    fill(0, 255, 0,150);
    textSize(30);
    translate(s1.x-s1.w-50, s1.y-s1.w-20, 0);
    text(message, 0, 0);
    popMatrix();
  }
  stroke(255);
  pushMatrix();
  for (int i=0; i<=10; i++) {
    if (i%10==0)
      strokeWeight(3);
    else
      strokeWeight(1);

    line(getX(width*i/10,0), getY(0,0), 0, getX(width*i/10,-1*derinlik),getY(0,-1*derinlik) , -1*derinlik);
    line(getX(0,0),getY(height*i/10,0) , 0, getX(0,-1*derinlik),getY(height*i/10,-1*derinlik) , -1*derinlik);
    line(getX(width*i/10,0),getY(height,0) , 0,getX( width*i/10,-1*derinlik),getY(height,-1*derinlik) , -1*derinlik);
    line(getX(width,0),getY(height*i/10,0) ,0, getX(width,-1*derinlik),getY(height*i/10,-1*derinlik) , -1*derinlik);

    line(getX(0,-1*derinlik*i/10),getY(0,-1*derinlik*i/10) , -1*derinlik*i/10, getX(width,-1*derinlik*i/10),getY(0,-1*derinlik*i/10) , -1*derinlik*i/10);
    line(getX(0,-1*derinlik*i/10),getY(0,-1*derinlik*i/10) , -1*derinlik*i/10, getX(0,-1*derinlik*i/10),getY(height,-1*derinlik*i/10) , -1*derinlik*i/10);
    line(getX(width,-1*derinlik*i/10),getY(0,-1*derinlik*i/10) , -1*derinlik*i/10, getX(width,-1*derinlik*i/10),getY(height,-1*derinlik*i/10) , -1*derinlik*i/10);
    line(getX(0,-1*derinlik*i/10), getY(height,-1*derinlik*i/10), -1*derinlik*i/10, getX(width,-1*derinlik*i/10),getY(height,-1*derinlik*i/10) , -1*derinlik*i/10);
  }
  popMatrix();

  stroke(0, 255, 0,150);
  strokeWeight(3);
  pushMatrix();
  line(getX(0,b.z), getY(0,b.z), b.z, getX(width,b.z), getY(0,b.z), b.z);
  line(getX(0,b.z), getY(0,b.z), b.z, getX(0,b.z), getY(height,b.z), b.z);
  line(getX(width,b.z), getY(0,b.z), b.z, getX(width,b.z), getY(height,b.z), b.z);
  line(getX(0,b.z), getY(height,b.z), b.z, getX(width,b.z), getY(height,b.z), b.z);
  popMatrix();
  
  noStroke();
  playBot(s2);
  s1.move();
  s2.move();  
  strokeWeight(1);
  b.move();
}

int getY(int y,int z){
double distance = height/2-camY;
double camZ =(height/2) / tan(PI/6);
double dy = 0;

if(z*distance!=0)
 dy= (z*distance)/camZ;
return (int)dy+y;

}

int getX(int x,int z){
double distance = width/2-camX;
double camZ =(height/2) / tan(PI/6);
double dx = 0;

if(z*distance!=0)
 dx= (-z*distance)/camZ;
return (int)dx+x;

}

void playBot(stick s) {
  if ( abs(s.z - b.z)< derinlik*2/3 && b.zsp<0) {
    if (s.x-s.w/2<b.x) {
      s.hrkt[2]=true;
      s.hrkt[0]=false;
    } else if (s.x-s.w/2-b.x<4) {
      s.hrkt[2]=false;
      s.hrkt[0]=false;
    } else {
      s.hrkt[2]=false;
      s.hrkt[0]=true;
    }
    if (s.y-s.h/2<b.y) {
      s.hrkt[3]=true;
      s.hrkt[1]=false;
    } else if (s.y-s.h/2-b.y<4) {
      s.hrkt[3]=false;
      s.hrkt[1]=false;
    }else{
      s.hrkt[3]=false;
      s.hrkt[1]=true;
    }
  } else{
    if (s.x-s.w/2<width/2) {
      s.hrkt[2]=true;
      s.hrkt[0]=false;
    }else if (s.x-s.w/2-width/2<4) {
      s.hrkt[2]=false;
      s.hrkt[0]=false;
    } else {
      s.hrkt[2]=false;
      s.hrkt[0]=true;
    }
    if (s.y-s.h/2<height/2) {
      s.hrkt[3]=true;
      s.hrkt[1]=false;
    }else if (s.y-s.h/2-height/2<4) {
      s.hrkt[3]=false;
      s.hrkt[1]=false;
    } else {
      s.hrkt[3]=false;
      s.hrkt[1]=true;
    }
  }
}

void keyPressed() {
  if (keyCode==LEFT && s1.x>0)
    s1.hrkt[0]=true;
  if (keyCode==RIGHT && s1.x<width)
    s1.hrkt[2]=true;
  if (keyCode==UP && s1.y>0)
    s1.hrkt[1]=true;
  if (keyCode==DOWN && s1.y<height)
    s1.hrkt[3]=true;
  if (keyCode==ENTER)
    bekle=false;
}

void keyReleased() {
  if (keyCode==LEFT )
    s1.hrkt[0]=false;
  if (keyCode==RIGHT )
    s1.hrkt[2]=false;
  if (keyCode==UP )
    s1.hrkt[1]=false;
  if (keyCode==DOWN )
    s1.hrkt[3]=false;
}
