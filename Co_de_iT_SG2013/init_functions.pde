

// ___________________HORMONS

void initHormons(Hormon[] hArr) {

  for (int i=0; i< nHorm; i++) {
    float r = sqrt(random(1))*(rad/3);
    //float r = random(1)*rad;
    float ang = random(TWO_PI);
    float x = rad/2+r*cos(ang);
    float y = rad/2+r*sin(ang);
    //float z = noise(xSize/(2+r*cos(ang)*nScale), ySize/(2+ r*sin(ang)*nScale))*300;
    float z = noise(x/ (float)(nScale), y/ (float)(nScale))*300;
    //Vec3D pos = new Vec3D (xSize/2+r*cos(ang), ySize/2+ r*sin(ang), z);
    Vec3D pos = new Vec3D (x*2, y*2, z);
    hArr[i] = new Hormon (pos, hRad);
  }
}

void initHormons_img(Hormon[] hArr, PImage base) {
  int count = 0;
  int r1 = (int) rad;
  base.loadPixels();
  while (count<nHorm) {
    int x = (int)(random(1)*r1);
    int y = (int)(random(1)*r1);
    int ind = y*r1+x;
    if (brightness(base.pixels[ind]) < 220) { // 200
      float z = noise(x/ (float)(nScale), y/ (float)(nScale))*200;
      Vec3D pos = new Vec3D (x*2, y*2, z);
      hArr[count] = new Hormon (pos, hRad);
      count++;
    }
  }
}


// ___________________BUDS

void initBuds(ArrayList <Bud> bArr, int nBud) {
  float ang = TWO_PI/ (float)(nBud);
  for (int i=0; i< nBud; i++) {
    float r = random(rad/10, rad/5);
    //Vec3D pos = new Vec3D(xSize/2+40*cos(ang*i), ySize/2+ 40*sin(ang*i), 0);
    Vec3D pos = new Vec3D(rad+r*cos(ang*i), rad+r*sin(ang*i), 0);
    Vec3D dir = new Vec3D(rad, rad, 0).sub(pos);
    dir.normalizeTo(budStep).scaleSelf(-1); // face dir outwards
    Bud b = new Bud(pos, dir, budStep);
    b.trail.add(new Vec3D(b.pos));
    bArr.add(b);
  }
}

