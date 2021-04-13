class PlayerOne {
  Box box;

  PlayerOne(float x, float y) {
    box = new Box(x, y, 50, 50, false);
  }

  void display() {
    box.display();
  }

  // controls
  void applyWind() {
    // apply the wind force when mouse is pressed
    //if (keyPressed && (key == 'd')) {
    //  Box b = this.box;
    //  Vec2 wind = new Vec2(f, 0);
    //  box.applyForce(wind);
    //} 
    //if (keyPressed && (key == 'a')) {
    //  Box b = this.box;
    //  Vec2 wind = new Vec2(-f, 0);
    //  box.applyForce(wind);
    //}

    //// controls
    //if (keyPressed) {
    //  if (key == 'd' || key == 'D') {
    //    Box b = this.box;
    //    Vec2 wind = new Vec2(f, 0);
    //    box.applyForce(wind);
    //  } else if (key == 'a' || key == 'A') {
    //    Box b = this.box;
    //    Vec2 wind = new Vec2(-f, 0);
    //    box.applyForce(wind);
    //  }
    //}

    if (right1 == true) {
      Box b = this.box;
      Vec2 wind = new Vec2(force, 0);
      box.applyForce(wind);
    }
    if (left1 == true) {
      Box b = this.box;
      Vec2 wind = new Vec2(-force, 0);
      box.applyForce(wind);
    }
    if (up1 == true) {
      Box b = this.box;
      Vec2 wind = new Vec2(0, jumpSpeedP1);
      box.applyForce(wind);
    }

    //  if (right == true) {
    //    Box b = this.box;
    //    Vec2 wind = new Vec2(f, 0);
    //    box.applyForce(wind);
    //  }
    //  if (left == true) {
    //    Box b = this.box;
    //    Vec2 wind = new Vec2(-f, 0);
    //    box.applyForce(wind);
    //  }
    //}

    //void keyPressed() {
    //  if (key == 'd' || key == 'D') {
    //    right = true;
    //    println("d press");
    //  }
    //  if (key == 'a' || key == 'A') {
    //    left = true;
    //    println("a press");
    //  }
    //}

    //void keyReleased() {
    //  if (key == 'd' || key == 'D') {
    //    right = false;
    //  }
    //  if (key == 'a' || key == 'A') {
    //    left = false;
    //  }
  }
}
