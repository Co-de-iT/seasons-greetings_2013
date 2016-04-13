class Bud {

  Vec3D pos, dir;
  boolean alive=true;
  color col = color(255, 0, 0);
  color hCol;
  float step;
  float range = rad/2;
  float cAngVis = cos(HALF_PI); // cosine of visual angle
  ArrayList <Vec3D> trail = new ArrayList<Vec3D>();
  ArrayList <Hormon> budHArr = new ArrayList<Hormon>();



  Bud(Vec3D _pos, Vec3D _dir, float _step) {
    pos = _pos;
    dir = _dir;
    step =_step;
  }
  
    Bud(Vec3D _pos, Vec3D _dir) {
    this (_pos, _dir, 20);

  }
  
  /*  Bud(Vec3D _pos, Vec3D _dir) {
    pos = _pos;
    dir = _dir;
    step = 20;
  }*/


  // sequence

  /*

   . assign hormons
   . calculate (progressively removing hormons beyond angle)
   . redistribute hormons on branching
   
   */


  void update() {
    // if there are close hormons....
    if (budHArr.size()>0) { 

      boolean newBud = false; 

      // get average point
      Vec3D average = new Vec3D();
      int count=0;

      pushStyle();
      stroke(120, 100);
      strokeWeight(0.5);

      for (int i=0; i< budHArr.size(); i++) {
        Hormon h = budHArr.get(i);
        Vec3D hDir = h.pos.sub(pos);
        float cAng = dir.normalize().dot(hDir.normalize()); // using cosines: cos(0) = 1, cos(HALF_PI) = 0

        // if an hormon is alive and in range use it for average calculation
        if (cAng>=cAngVis && h.alive /*&& hDir.magnitude() < range*/) {
          // verify closeness to hormon > if close hormon dies
          if (pos.distanceTo(h.pos)<h.rad) {
            h.alive = false;
            h.phase = frameCount;
          } 
          else {
            average.addSelf(h.pos);
            count++;
          }
        }
        else if (cAng < cAngVis && h.alive && !newBud) {
          newBud=true;
          if (bArr.size()<30000) { // limits buds to a max of 30000 (can be commented if buds number does not rocket up to 450000 or more!
            Bud b = new Bud (new Vec3D(pos), new Vec3D(hDir.normalizeTo(step)), step);
            b.trail.add(new Vec3D(pos));
            bArr.add(b);

          }
        }
      } // end for (int i=0; i< budHArr.size(); i++)

      if (count>0) {
        average.scaleSelf(1/(float)count);
      }
      else {
        average = new Vec3D(pos);
        alive = false;
        col = color(118, 255, 0);
      }
      dir = average.sub(pos).normalizeTo(step);
      pos.addSelf(dir);
      trail.add(new Vec3D(pos));
    } // end if budHArr.size >0
    else {
      alive = false;
      col = color(118, 255, 0);
    }
  }

  void display() {
    pushStyle();
    //stroke(col);
    stroke(0);
    strokeWeight(3);
    point(pos.x, pos.y, pos.z);
    stroke(255);
    strokeWeight(1);
    Vec3D fLoc = pos.add(dir);
    line(pos.x, pos.y, pos.z, fLoc.x, fLoc.y, fLoc.z);
    popStyle();
  }

  void dispHConn() {
    for (Hormon h: budHArr) {
      if (h.alive) {
        stroke(80, 100);
        line(pos.x, pos.y, pos.z, h.pos.x, h.pos.y, h.pos.z);
      }
    }
  }

  void drawTrail(boolean curv) {
    pushStyle();
    stroke(0);
    strokeWeight(1);
    noFill();
    if (curv) {
      beginShape();
      for (Vec3D v: trail) {
        curveVertex(v.x, v.y, v.z); // draw as curve
      }
      endShape();
    } 
    else {
      float step;
      for (int i=0; i< trail.size()-1; i++) {
        step = i / (float) (trail.size()-1);
        Vec3D v = trail.get(i);
        Vec3D v2 = trail.get(i+1);
        stroke(lerpColor(color(#CBCBCB), color(#FF0307), step));
        strokeWeight(1);
        line (v.x, v.y, v.z, v2.x, v2.y, v2.z);
        strokeWeight(3);
        point(v.x, v.y, v.z);
      }
    }
    popStyle();
  }
}

