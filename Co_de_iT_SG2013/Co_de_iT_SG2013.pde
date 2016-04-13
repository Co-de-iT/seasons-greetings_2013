/*

 Co-de-iT season's greetings and Happy Holidays for 2013!
 
 code written by Alessio Erioli - Co-de-iT
 
 code history:
 
 . the code is an implementation of a branching system seeking "hormons" in space
 inspired by the "Hyphae" work of nervous system - https://vimeo.com/25604611
 . a version was developed by Niccolò Ciuppani, Nicola Fuzzi and Alessia Masini for the 2013 a3 course
 at the University of Bologna; I helped with a few issues but then decided to re-write the code myself
 from scratch. However, their work provided a big help in finding bugs and developing the whole thing.
 
 ________________________________________________
 
 . instructions
 
 . start with CTRL+SHIFT+R (or Sketch > Present)
 . press: 
 ... space bar to start/stop animation
 ... 'r' to reset branching 
 ... 'w' to switch hormon distribution between flower and logo
 ... 'a' to show/hide branch-hormon connection
 ... 'h' to show/hide hormons before branches reach them (try this before running the animation)
 ... 's' to save a screenshot (you'll find it in your desktop in the /Co-de-iT_images folder)
 ... 'd' to save a pdf fil of the branching (you'll find it in your desktop in the /Co-de-iT_pdf folder)
 
 
 ________________________________________________
 
 . options
 
 . place your image instad of the Co-de-iT logo in the /data folder
 
 ________________________________________________
 
 . distribution
 
 . this code is distributed under Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
 ... http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US
 
 
 You are free to:
 
 . Share — copy and redistribute the material in any medium or format
 . Adapt — remix, transform, and build upon the material
 
 The licensor cannot revoke these freedoms as long as you follow the license terms.
 
 Under the following terms:
 
 . Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
   You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
 . NonCommercial — You may not use the material for commercial purposes.
 . ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under 
   the same license as the original.
 
 No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from 
 doing anything the license permits.
 
 
 */


import toxi.geom.*;
import peasy.*;
import processing.dxf.*;
import processing.pdf.*;

int nHorm = 1500;
int nBud = 5;
int xSize = 1080;
int ySize = 720;
float rad = 500;
float hRad = 3;
float budStep = 5;
float nScale = 100;
String dest;

PeasyCam cam;

boolean go = false, recPdf = false, viewConn=false, viewHorm=false, logoDist=true;

Hormon[] hArr = new Hormon[nHorm];
ArrayList <Bud> bArr = new ArrayList<Bud>();

PImage base, signature;


void setup() {

  //size(xSize, ySize, P3D); // uncheck these and check the following for a non-fullscreen version
  size(displayWidth, displayHeight, P3D);
  smooth(4);
  hint(ENABLE_STROKE_PURE);
  hint(DISABLE_DEPTH_MASK);

  imageMode(CENTER);
  cam = new PeasyCam(this, rad, rad, 0, 800);
  signature = loadImage("Co-de-iT_signature.png");
  base = loadImage("base.jpg");
  base.resize((int)rad, (int)rad);
  dest = System.getProperty("user.home")+"/Desktop/";
  if (logoDist) {
    initHormons_img(hArr, base);
  }
  else {
    initHormons(hArr);
  }
  initBuds(bArr, nBud);
}



void draw() {
  background(0);
  if (recPdf) {
    PGraphicsPDF pdf = (PGraphicsPDF)beginRaw(PDF, dest+"Co-de-iT_pdf/Co-de-iT_2013_####.pdf");
    pdf.strokeJoin(MITER);
    pdf.strokeCap(SQUARE);
  }

  for (int i=0; i< nHorm; i++) {
    hArr[i].display();
  }
  assignHormons();
  int buds = bArr.size();
  for (int i=0; i<buds; i++) {
    Bud b = bArr.get(i);
    if (go && b.alive) { 
      b.update();
    }
    b.display();
    if (viewConn) b.dispHConn();
    if (b.trail.size() >=2) b.drawTrail(false);
  }

  if (recPdf) {
    endRaw();
    recPdf= false;
  }

  cam.beginHUD();
  image(signature, signature.width/2, signature.height/2);
  cam.endHUD();
}

// ____________________________________ keyboard functions

void keyPressed() {
  if (key ==' ') go = !go;
  if (key=='s' || key =='S') saveFrame(dest+"Co-de-iT_images/Co-de-iT_2013_####.png");
  if (key=='d' || key =='D') recPdf = true;
  if (key=='r' || key =='R') reset();
  if (key=='a' || key =='A') viewConn= !viewConn;
  if (key=='h' || key =='H') viewHorm= !viewHorm;
  if (key=='w' || key =='W') {
    logoDist = !logoDist;
    reset();
  }
}

// ____________________________________ reset

void reset() {
  bArr.clear();
  go = false;
  nBud = (int) random(3, 10);
  if (logoDist) {
    initHormons_img(hArr, base);
  }
  else {
    initHormons(hArr);
  }
  initBuds(bArr, nBud);
}

