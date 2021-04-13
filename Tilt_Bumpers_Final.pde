/*  
  This program is designed by Alex Li, Jared Ireland and Trae Gallemit-Fraser
  using examples from Daniel Shiffman's textbook 'the Nature of Coding'
  2021-04-06
*/


import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

import processing.serial.*;

String myString = null;
Serial myPort;


int NUM_OF_VALUES = 6;   /** establishes number of values coming from Arduino **/
int[] sensorValues;      /** this array stores values from Arduino **/

Box2DProcessing box2d;

PlayerOne p1;
PlayerTwo p2;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

boolean right1;
boolean left1;
boolean up1;
boolean right2;
boolean left2;
boolean up2;

float force = 250; // default: 100
float jumpSpeedP1 = 0; // default: 0?
float jumpSpeedP2 = 0;
float opacity = 100;
float bounciness = 0.5; // default: 0.5
PImage img;

void setup() {
  size(640, 360);
  img = loadImage("sky background image.jpeg");

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -10);

  // player starting points
  p1 = new PlayerOne(width/2-200, 100);
  p2 = new PlayerTwo(width/2+200, 100);

  // Create ArrayLists  
  boundaries = new ArrayList<Boundary>();
  particles = new ArrayList<Particle>();

  // Add a bunch of fixed boundaries
  //boundaries.add(new Boundary(width/4,height-5,width/2-50,10));
  //boundaries.add(new Boundary(3*width/4,height-50,width/2-50,10));

  boundaries.add(new Boundary(width/2-200, height/2-50, 50, 10));
  boundaries.add(new Boundary(width/2+200, height/2-50, 50, 10));
  boundaries.add(new Boundary(width/2, height/2+50, 200, 10));
  boundaries.add(new Boundary(width/2, 0, width, 10));
  //boundaries.add(new Boundary(5,height/2,10, height));
  //boundaries.add(new Boundary(width-5,height/2,10, height));
  
  //
  setupSerial();
}

void draw() {
  background(255);
  image(img, 0, 0);
  
  /// set the jump speed equal to the ultrasonic sensor values
  jumpSpeedP1 = sensorValues[0]*10;
  jumpSpeedP2 = sensorValues[3]*10;
  
  /// Updates and prints list of values coming from arduino
  updateSerial();
  printArray(sensorValues);
  
  inputCheck();
  releaseCheck();
  
  if (random(1) < 0.1) {
    float sz = random(4, 8);
    particles.add(new Particle(random(width), 20, sz));
  }

  // Look at all particles
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      particles.remove(i);
    }
  }

  // We must always step through time!
  box2d.step();

  // Display all the boundaries
  for (Boundary wall : boundaries) {
    wall.display();
  }

  p1.applyWind();
  p2.applyWind();
  p1.display();
  p2.display();

  if (frameCount < 300) {
    info();
  }
}

// inputs
void inputCheck() {
  if (sensorValues[2] == 1) {
    right1 = true;
  }
  if (sensorValues[1] == 1) {
    left1 = true;
  }
  if (sensorValues[0] > 0 && sensorValues[0] < 100) {
    up1 = true;
  }
  if (sensorValues[5] == 1) {
    right2 = true;
  }
  if (sensorValues[4] == 1) {
    left2 = true;
  }
  if (sensorValues[3] > 0 && sensorValues[3] < 100) {
    up2 = true;
  }
}

void releaseCheck() {
  if (sensorValues[2] == 0) {
    right1 = false;
  }
  if (sensorValues[1] == 0) {
    left1 = false;
  }
  if (sensorValues[0] <= 0 && sensorValues[0] >= 100) {
    up1 = false;
  }
  if (sensorValues[5] == 0) {
    right2 = false;
  }
  if (sensorValues[4] == 0) {
    left2 = false;
  }
  if (sensorValues[3] <= 0 && sensorValues[3] >= 100) {
    up2 = false;
  }
}

void info() {
  textAlign(CENTER);
  textSize(32);
  fill(255, 0, 0);
  String P1 = "Player 1";
  text(P1, width/2-200, 50);
  fill(0, 0, 255);
  String P2 = "Player 2";
  text(P2, width/2+200, 50);
}
