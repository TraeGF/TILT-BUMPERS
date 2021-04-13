// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A rectangular box

class Box {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;

  // Constructor
  Box(float x, float y, float w_, float h_, boolean lock) {
    w = w_;
    h = h_;

    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.position.set(box2d.coordPixelsToWorld(new Vec2(x, y)));
    if (lock) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;

    body = box2d.createBody(bd);

    // Define the shape -- a  (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.1;
    fd.restitution = bounciness;

    body.createFixture(fd);

    body.setLinearVelocity(new Vec2(0, 0));
    body.setAngularVelocity(0);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }

  void setAngularVelocity(float a) {
    body.setAngularVelocity(a);
  }

  void setVelocity(Vec2 v) {
    body.setLinearVelocity(v);
  }

  void setposition(float x, float y) {
    Vec2 pos = body.getWorldCenter();
    Vec2 target = box2d.coordPixelsToWorld(x, y);
    Vec2 diff = target.sub(pos);
    diff.mulLocal(50);
    setVelocity(diff);
    setAngularVelocity(0);
  }

  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(255,0,0,opacity); // red
    stroke(0);
    strokeWeight(1);
    rect(0, 0, w, h);
    popMatrix();
  }
}
