class Hormon {

  Vec3D pos;
  float rad;
  int phase = 0;
  color col = color(0, 0, 0, 50);
  boolean alive = true;
  PImage on = loadImage("sprite.png");

  Hormon(Vec3D _pos, float _rad) {
    pos = _pos;
    rad = _rad;
    on.resize(32, 32);
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    pushStyle();
    fill(col);
    noStroke();
    if (alive) {
      if (viewHorm) { 
        ellipse(0, 0, rad*2, rad*2);
        stroke(0);
        strokeWeight(2);
        point(0, 0, 0);
        strokeWeight(1);
      }
    } 
    else {
      float cRad = 5;
      if ((phase+frameCount)%20<8) {
        strokeWeight(5);
        stroke(255, 255, 255);
        image(on, 0, 0);
      }
      else {
        strokeWeight(2);
        stroke(255, 0, 0);
      }

      noFill();
      ellipse(0, 0, cRad, cRad);
    }
    popStyle();
    popMatrix();
  }
}

