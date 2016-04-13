

void assignHormons() {

  // clear hormons arrays in buds
  for (Bud b:bArr) {
    b.budHArr.clear();
  }

  // reassign hormons
  for (int i=0; i<hArr.length; i++) {

    if (hArr[i].alive) { // if hormon is active
      float minDist = 9999999;
      int bInd = -1;

      // find closest bud for each alive hormon
      for (int j=0; j<bArr.size(); j++) {
        Bud b = bArr.get(j);
        if (b.alive) {
          Vec3D hDir = hArr[i].pos.sub(b.pos);
          float dist = b.pos.distanceTo(hArr[i].pos);
          if (dist < minDist) {
            minDist = dist;
            bInd = j;
          }
        }
      }

      // add hormon to relative bud hormon list
      if (bInd!=-1) {
        // change hormon color according to nearest bud
        float colInd = (float) bInd/bArr.size();
        //hArr[i].col = lerpColor(color(0, 255, 255, 50), color(255, 0, 255, 50), colInd);
        hArr[i].col = lerpColor(color(80, 50), color(200, 50), colInd);
        Bud b = bArr.get(bInd);
        b.budHArr.add(hArr[i]);
      }
      else {

        hArr[i].col = color(0, 0, 0);
      }
    }
  }
}
