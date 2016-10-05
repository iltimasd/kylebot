import drop.*;
import java.awt.*;
import java.awt.event.*;
public Robot robot;
public SDrop drop;
public String dropText;
public String pen = "Pen Pineapple Apple Pen";
PImage kyle;
int w = 50;
int hA;   //hue value A
int hB;   //hue value B
int stA;  //saturation value A
int stB;  //saturation value B
int bA;   //brightness value A
int bB;   //brightness value B
int a;
int ca;

boolean sA = false; //slider state
boolean sB = false;
boolean sC = false;
boolean sD = false;
boolean sE = false;
boolean sF = false;
boolean lockedA = false; //click and drag lock
boolean lockedB = false;
boolean lockedC = false;
boolean lockedD = false;
boolean lockedE = false;
boolean lockedF = false;
int sAx = 350; 
int sAy = 50;
int sBx = 250; 
int sBy = 115;
int sCx = 50; 
int sCy = 375;
int sDx = 125; 
int sDy = 375;
int sEx = 549-w; 
int sEy = 375;
int sFx = sEx-w-25; 
int sFy = 375;
PImage photo;

void setup() {
  size(600, 600);
  surface.setTitle("| ! |  I am Kylebot | ! |");
  //dropped=loadShape("drop.svg");
  //copied=loadShape("copy.svg");
  kyle=loadImage("kyle.png");
  //dropped.disableStyle();  
  //copied.disableStyle();  
  drop = new SDrop(this);
  try { 
    robot = new Robot();
    robot.setAutoDelay(0);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  background(0, 0, 100);
  //slider constraints
  sAx=constrain(sAx, 50, 550-w);
  sBx=constrain(sBx, 50, 550-w);
  sCy=constrain(sCy, 375, height-w-25);
  sDy=constrain(sDy, 375, height-w-25);
  sEy=constrain(sEy, 375, height-w-25);
  sFy=constrain(sFy, 375, height-w-25);
  //map slider position to respective value
  hA=int(map(sAx, 50, 550-w, 1, 99));
  hB=int(map(sBx, 50, 550-w, 1, 99));
  stA=int(map(sCy, 375, height-w-25, 1, 99));
  stB=int(map(sFy, 375, height-w-25, 1, 99));
  bA=int(map(sDy, 375, height-w-25, 1, 98));
  bB=int(map(sEy, 375, height-w-25, 1, 98));
  a=constrain(a, 0, 100);
  ca=constrain(ca, 0, 100);

  colorMode(HSB, 100, 100, 100, 100);
  //Hue guides
  for (int i=0; i<450; i++) {
    stroke(lerpColor(color(1, 100, 100), color(99, 100, 100 ), i/450.0));
    line(75+i, sAy+w, 75+i, sBy);
  }
  //S+B guides
  for (int i=0; i<(height-w-400); i++) {
    stroke(lerpColor(color(hA, 98, 100), color(hA, 1, 100 ), i/(height-w-400.0)));
    line (50, 400+i, 50+w, 400+i);
    stroke(lerpColor(color(hB, 98, 100), color(hB, 1, 100 ), i/(height-w-400.0)));
    line(424, 400+i, 424+w, 400+i);
    stroke(lerpColor(color(hA, 100, 98), color(hA, 100, 1 ), i/(height-w-400.0)));
    line(125, 400+i, 125+w, 400+i);
    stroke(lerpColor(color(hB, 100, 98), color(hB, 100, 1 ), i/(height-w-400.0)));
    line(500-1, 400+i, 500+w-1, 400+i);
  }
  //final graidient
  for (int i=0; i<500; i++) {
    stroke(lerpColor(color(hA, 100-stA, 100-bA), color(hB, 100-stB, 100-bB), i/500.0));
    line(i+50, width/2-70, i+50, width/2+30) ;
  }
  noStroke();
  fill(0, 0, 100, 75);
  if (sAx<sBx) {
    rect(75, 50+w, sAx-w, sBy-sAy-(w)+1);
    rect(sBx+w/2, 50+w, 500-sBx, sBy-sAy-(w)+1);
  } else {
    rect(75, 50+w, sBx-w, sBy-sAy-(w)+1);
    rect(sAx+w/2, 50+w, 500-sAx, sBy-sAy-(w)+1);
  }
  fill(0, 0, 100);

  rect(51, 400, 49, 150);
  rect(425, 400, 49, 150);
  rect(126, 400, 49, 150);
  rect(500, 400, 49, 150);




  ellipseMode(CORNER);
  //draw and color sliders
  stroke(hA, 100, 100);
  if (lockedA) {
    fill(hA, 100, 100);
  } else {
    noFill();
  }
  ellipse(sAx, sAy, w, w);

  stroke(hB, 100, 100);
  if (lockedB) {
    fill(hB, 100, 100);
  } else {
    noFill();
  }
  ellipse(sBx, sBy, w, w);

  noFill();

  stroke(hA, 120-stA, 100);
  if (lockedC) {
    fill(hA, 100-stA, 100);
    stroke(hA, 100, 100);
  } else {
    noFill();
  }
  ellipse(sCx, sCy, w, w);
  stroke(hA, 100, 110-bA);
  if (lockedD) {
    fill(hA, 100, 110-bA);
    stroke(hA, 100, 100);
  } else {
    noFill();
  }
  ellipse(sDx, sDy, w, w);
  if (lockedF) {
    fill(hB, 100-stB, 100);
    stroke(hB, 100, 100);
  } else {
    noFill();
  }
  stroke(hB, 120-stB, 100);
  ellipse(sFx, sFy, w, w);
  if (lockedE) {
    fill(hB, 100, 110-bB);
    stroke(hB, 100, 100);
  } else {
    noFill();
  }
  stroke(hB, 100, 110-bB);
  ellipse(sEx, sEy, w, w);
  //part of click&drag logic
  if (mouseX>sAx && mouseX<sAx+w && mouseY>sAy && mouseY<sAy+w ) {
    sA = true;  
    if (!lockedA) {
    }
  } else {
    sA = false;
  }
  if (mouseX>sBx && mouseX<sBx+w && mouseY>sBy && mouseY<sBy+w ) {
    sB = true;  
    if (!lockedB) {
    }
  } else {
    sB = false;
  }
  if (mouseX>sCx && mouseX<sCx+w && mouseY>sCy && mouseY<sCy+w ) {
    sC = true;  
    if (!lockedC) {
    }
  } else {
    sC = false;
  }
  if (mouseX>sDx && mouseX<sDx+w && mouseY>sDy && mouseY<sDy+w ) {
    sD = true;  
    if (!lockedD) {
    }
  } else {
    sD = false;
  }
  if (mouseX>sEx && mouseX<sEx+w && mouseY>sEy && mouseY<sEy+w ) {
    sE = true;  
    if (!lockedE) {
    }
  } else {
    sE = false;
  }
  if (mouseX>sFx && mouseX<sFx+w && mouseY>sFy && mouseY<sFy+w ) {
    sF = true;  
    if (!lockedF) {
    }
  } else {
    sF = false;
  }
  tint(100, ca);
  image(kyle, 0, 0, width, height);
  ca-=7;

  //EoF
}


void mousePressed() {
  //part of click&drag logic
  if (sA) { 
    lockedA = true;
  } else {
    lockedA = false;
  }

  if (sB) { 
    lockedB = true;
  } else {
    lockedB = false;
  }

  if (sC) { 
    lockedC = true;
  } else {
    lockedC = false;
  }

  if (sD) { 
    lockedD = true;
  } else {
    lockedD = false;
  }

  if (sE) { 
    lockedE = true;
  } else {
    lockedE = false;
  }

  if (sF) { 
    lockedF = true;
  } else {
    lockedF = false;
  }
  //EOF
}

void mouseDragged() {
  //part of click&drag logic
  if (lockedA) {
    sAx=mouseX-w/2;
  }
  if (lockedB) {
    sBx=mouseX-w/2;
  }
  if (lockedC) {
    sCy=mouseY-w/2;
  }
  if (lockedD) {
    sDy=mouseY-w/2;
  }
  if (lockedE) {
    sEy=mouseY-w/2;
  }
  if (lockedF) {
    sFy=mouseY-w/2;
  }
}

void mouseReleased() {
  //part of click&drag logic
  lockedA = false;
  lockedB = false;
  lockedC = false;
  lockedD = false;
  lockedE = false;
  lockedF = false;
}

void keyReleased() {

  kylefy();
}

public void dropEvent(DropEvent theDropEvent) {
  // drag some text from e.g. a text editor into 
  // the sketch.
  a=150;

  dropText = theDropEvent.text();
  //trigger mouse click on drop to refocus sketch
  refocus();
}


public void kylefy() {

  ca=100;
  String input;
  //start of HTML block
  String output="<div><font size = \"5.8\"><b>";
  //if user wants output w/o putting output use default phrase "Pen Pineapple Apple Pen"
  noLoop(); //pause drawing while we do some work
  if (dropText==null) {
    input=pen;
  } else { 
    input=dropText;
  }
  //map color and add <font> to each char
  for (int i=0; i<input.length(); i++) {
    float l=input.length();
    println(i/l);
    output = output + "<font color=\"#";
    output = output + hex(lerpColor(color(hA, 100-stA, 100-bA), color(hB, 100-stB, 100-bB), i/l), 6);
    output = output + "\">"+input.charAt(i)+"</font>";
  }
  //close off HTML code
  output = output + "</div>";
  //copy to user's clipboard
  GClip.copy(output);
  println(true);
  loop();
}

void refocus() {
  robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
  robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
  robot.waitForIdle();
}