class PlayerTwo {
  Box2 box;

  PlayerTwo(float x, float y) {
    box = new Box2(x, y, 50, 50, false);
  }

  void display() {
    box.display();
  }

  // controls
  void applyWind() {
    // apply the wind force when mouse is pressed
    //if (keyPressed && (keyCode == RIGHT)) {
    //  Box b = this.box;
    //  Vec2 wind = new Vec2(f, 0);
    //  box.applyForce(wind);
    //} 
    //if (keyPressed && (keyCode == LEFT)) {
    //  Box b = this.box;
    //  Vec2 wind = new Vec2(-f, 0);
    //  box.applyForce(wind);
    //}

    //// controls
    //if (keyPressed) {
    //  if (key == CODED && keyCode == RIGHT) {
    //    Box b = this.box;
    //    Vec2 wind = new Vec2(f, 0);
    //    box.applyForce(wind);
    //  } else if (key == CODED && keyCode == LEFT) {
    //    Box b = this.box;
    //    Vec2 wind = new Vec2(-f, 0);
    //    box.applyForce(wind);
    //  }
    //}

    if (right2 == true) {
      Box2 b = this.box;
      Vec2 wind = new Vec2(force, 0);
      box.applyForce(wind);
    }
    if (left2 == true) {
      Box2 b = this.box;
      Vec2 wind = new Vec2(-force, 0);
      box.applyForce(wind);
    }
    if (up2 == true) {
      Box2 b = this.box;
      Vec2 wind = new Vec2(-0, jumpSpeedP2);
      box.applyForce(wind);
    }
  }
}
