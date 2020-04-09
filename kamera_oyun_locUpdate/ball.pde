class ball {
  int x, y, z, r;
  int xsp, ysp, zsp;
  color c;

  ball() {
    x=width/2;
    y=height/2;
    z=0;
    xsp=(int)random(-5, 5);
    ysp=(int)random(-5, 5);
    zsp=-5;
    r=10;
    c=color(255);
  }

  void move() {
    int cx=0, cy=0, cz=0;
    if (x>width-r) {
      x=width-r;
      xsp *=-1;
      cx=x;
      cy=y;
      cz=z;
    }
    if (x<r) {
      x=r;
      xsp *=-1;
      cx=x;
      cy=y;
      cz=z;
    }
    if (y>height-r) {
      y=height-r;
      ysp *=-1;
      cx=x;
      cy=y;
      cz=z;
    }
    if (y<r) {
      y=r;
      ysp *=-1;
      cx=x;
      cy=y;
      cz=z;
    }
    if (z>-r) {
      z=-r;
      if ( x>s1.x-s1.w && x<s1.x && y>s1.y-s1.h && y<s1.y) {
        if (s1.x-x>s1.w*2/3)
          xsp--;
        else if (s1.x-x<s1.w/3)
          xsp++;
        if (s1.y-y>s1.h*2/3)
          ysp--;
        else if (s1.y-y<s1.h/3)
          ysp++;
        zsp *=-1;
        zsp--;
      } else {
        score2++;             
        s1= new stick(0, color(255, 200, 200, 200));
        s2= new stick(-derinlik, color(200, 200, 255, 200));
        b= new ball();
        message="! AMANIN !";
        time=millis();
      }
    }
    if (z<-derinlik+r) {
      z=-derinlik+r;
      if ( x>s2.x-s2.w && x<s2.x && y>s2.y-s2.h && y<s2.y) {
        if (s2.x-x>s2.w*2/3)
          xsp--;
        else if (s2.x-x<s2.w/3)
          xsp++;
        if (s2.y-y>s2.h*2/3)
          ysp--;
        else if (s2.y-y<s2.h/3)
          ysp++;
        zsp *=-1;
        zsp++;
      } else {
        score1++;             
        s1= new stick(0, color(255, 200, 200, 200));
        s2= new stick(-derinlik, color(200, 200, 255, 200));
        b= new ball();   
        message="! HELAAL !";
        time=millis();
      }
    }

    x=x+xsp;
    y=y+ysp;
    z=z+zsp;

    if (cx!=0 || cy!=0 || cz!=0) {
      for (int i=0; i<3; i++)
        carpma[1][i]=carpma[0][i];
      carpma[0][0]=cx;
      carpma[0][1]=cy;
      carpma[0][2]=cz;
    }

    pushMatrix();
    fill(255, 0, 0);
    translate(getX(carpma[1][0],carpma[1][2]), getY(carpma[1][1],carpma[1][2]), carpma[1][2]); 
    ellipse(0, 0, 10, 10);
    popMatrix();

    pushMatrix();
    translate(getX(carpma[0][0],carpma[0][2]), getY(carpma[0][1],carpma[0][2]), carpma[0][2]);
    ellipse(0, 0, 10, 10);
    popMatrix();

    pushMatrix();
    noStroke();
    fill(c);
    translate(getX(x,z), getY(y,z), z); 
    sphere(r);
    popMatrix();
  }
}
