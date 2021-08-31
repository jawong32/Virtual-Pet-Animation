import processing.serial.*;
import cc.arduino.*;

final Arduino arduino = new Arduino(this, Arduino.list()[0], 56700);
final int HEAD_CENTER = 250;

void setup() {
  size(500, 700);
  background(0);
  rectMode(CENTER);
  noStroke();  
}

void draw() {
  final int light = lightLevel();
  head();
  ears();
  eyes(light);
  horns();
  eyebrows(light/5-10);
  printCoordinates();
  System.out.println(light);
}

int lightLevel() {
  if (arduino.analogRead(5) < 50) {
    return 50;
  }
  if (arduino.analogRead(5) > 230) {
    return 230;
  }
  return arduino.analogRead(5);
}

void head() {
  fill(150);
  rect(HEAD_CENTER, 400, 200, 350, 20);
  ellipse(250, 230, 195, 50);
}

void ears() {
  rotate(radians(-30));
  pushMatrix();
  translate(-200, 10);
  arc(150, 330, 150, 60, 0, 180);
  popMatrix();
  rotate(radians(60));
  pushMatrix();
  translate(140, -250);
  fill(150);
  arc(350, 335, 150, 60, 0, 180);
  popMatrix();
  rotate(radians(-30));
}

void eyes(int light) {
  fill(255, 255, 255);
  ellipse(215, 350, 40, 40);
  ellipse(285, 350, 40, 40);
  fill(0);
  ellipse(215, 350, light / 8, light / 8);
  ellipse(285, 350, light / 8, light / 8);
}

void horns() {
  fill(255);
  quad(170, 245, 70, 225, 57, 280, 160, 295);
  quad(330, 245, 430, 225, 443, 280, 340, 295);
  quad(57, 280, 27, 217, 72, 134, 70, 225);
  quad(443, 280, 473, 217, 428, 134, 430, 225);
  fill(150);
  ellipse(160, 270, 30, 90);
  ellipse(340, 270, 30, 90);
}

void eyebrows(int light) {
  fill(30);
  quad(188, 315-light, 233, 325-light, 238, 340-light, 190, 330-light);
  quad(302, 315-light, 267, 325-light, 262, 340-light, 310, 330-light);
  //quad(188, light, 233, light + 12, 238, light + 24, 190, light + 16);
  //quad(302, light, 267, light + 12, 262, light + 24, 310, light + 16);
}

void printCoordinates() {
  if (mousePressed) {
      System.out.println(String.format("(%d, %d)", mouseX, mouseY));
  }
}
