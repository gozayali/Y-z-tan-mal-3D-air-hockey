class stick {
  int x, y, z, w, h;
  int xsp, ysp;
  color c;
  boolean[] hrkt= new boolean[4];

  stick(int z_, color c_) {
    xsp=0;
    ysp=0;
    w=60;
    h=60;
    x=width/2+w/2;
    y=height/2+h/2;
    z=z_;
    c=c_;
    for (int i=0; i<4; i++)
      hrkt[i]=false;
  }

  void move() {

    if (x<w) {
      xsp=0;
      x=w;
    } 
    if (x>width) {
      xsp=0;
      x=width;
    }
    if (y<h) {
      ysp=0;
      y=h;
    } 
    if (y>height) {
      ysp=0;
      y=height;
    }

    if (hrkt[0])
      xsp = -4;
    if (hrkt[2])
      xsp = 4;
    if (hrkt[1])
      ysp = -4;
    if (hrkt[3])
      ysp = 4;

    if ( !hrkt[1] && !hrkt[3])
      ysp=0;
    if (!hrkt[0] && !hrkt[2])
      xsp=0;

    x=x+xsp;
    y=y+ysp;
    pushMatrix();
    fill(c);
    int dz= ( z==0? z+10 : z-10); 
    translate( getX(x-w/2,dz) , getY(y-h/2,dz), dz);
    box(w, h, 10);
    popMatrix();
  }
}
