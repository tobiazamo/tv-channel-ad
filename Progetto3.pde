import ddf.minim.*;

PFont uncle;
float leftEllipseWidth = 0;
float leftEllipseHeight = 0;
float rightEllipseWidth = 0;
float rightEllipseHeight = 0;
float radiusX =0;
float arcRadiusX =0;
float arcRadiusY=0;
float rightAngle = HALF_PI*3;
float leftAngle = TWO_PI-HALF_PI;
float arcDirLeft = TWO_PI;
float arcDirRight = -PI;
float arcDirLeft2 = TWO_PI;
float arcDirRight2 = -PI;
float arcDirRight3 = 0;
float cut2 = TWO_PI;
float cut = 0;
float cut3 = 0;
float cut4 = 0;
float x = 0;
float y = 0;
float z=360;
float f= 0;
float g= 90;
float h= -HALF_PI;
float i= -90;
float endAngle = -HALF_PI;
float textsize = 0;
float m = 370;
float linesize = m;

Minim minim;
AudioPlayer player;

void setup() {
  fullScreen(P2D);
  //size(1024, 576, P2D);
  background(#530c63);
  minim = new Minim(this);
  player = minim.loadFile("Dragons.mp3", 1024);
  player.play(182800);
}


void draw() {
  background(#530c63);
  animArc();
}


void animArc() {

  strokeCap(PROJECT);
  // archi iniziali a sinistra e destra
  if (rightAngle > TWO_PI-0.001 && leftEllipseWidth == 0) {
    arcDirLeft = lerp(arcDirLeft, 0, 0.03);
    arcDirRight = lerp(arcDirRight, PI, 0.03);
    noFill();
    strokeWeight(25);
    stroke(249, 139, 233);
    arc(width, height, width/1.5, width/1.5, arcDirLeft - QUARTER_PI, arcDirLeft); // right arc that cuts out
    arc(0, height, width/1.5, width/1.5, arcDirRight, arcDirRight+QUARTER_PI); // left arc that cuts out
  }


  // cerchi iniziali a sinistra e destra
  if (arcDirRight < PI && leftEllipseWidth == 0) {
    fill(206, 68, 237);
    rightAngle = lerp(rightAngle, TWO_PI, 0.12);
    leftAngle = lerp(leftAngle, PI, 0.12);
    noStroke();
    arc(0, height, width/1.8, width/1.8, PI, rightAngle); // left arc
    arc(width, height, width/1.8, width/1.8, leftAngle, TWO_PI); // right arc
  }


  // traslazione dei cerchi verso il centro
  if (arcDirRight > HALF_PI && rightEllipseWidth < width/2-0.5) {
    fill(206, 68, 237);
    noStroke();
    float ease = 0.08;
    leftEllipseWidth = lerp(leftEllipseWidth, width/2, ease);
    leftEllipseHeight = lerp(leftEllipseHeight, height/2, ease);

    rightEllipseWidth = lerp(rightEllipseWidth, width/2, ease);
    rightEllipseHeight = lerp(rightEllipseHeight, height/2, ease);

    ellipse(leftEllipseWidth, height-leftEllipseHeight, width/1.8, width/1.8);
    ellipse(width-rightEllipseWidth, height-rightEllipseHeight, width/1.8, width/1.8);
  }


  //archi veloci
  if (leftEllipseWidth>=width/5 && leftEllipseWidth < width/3) {
    strokeWeight(10);
    stroke(255, 255, 100);
    noFill();
    arcDirLeft2 = lerp(arcDirLeft2, 0, 0.12);
    arcDirRight2 = lerp(arcDirRight2, PI, 0.12);
    arc(width, height-40, width, height*2, arcDirRight2 - PI, arcDirRight2); // right arc that cuts out
    arc(0, height-40, width, height*2, arcDirLeft2, arcDirLeft2+PI); // left arc that cuts out
  }

  // cercho che si restringe e archi che compaiono
  if (leftEllipseWidth > width/2-0.6) {
    fill(206, 68, 237);
    noStroke();
    float radius = width/1.8-radiusX;
    radiusX += radius * 0.075;

    ellipse(width/2, height/2, width/1.8-radiusX, width/1.8-radiusX);

    arcDirRight3 = lerp(arcDirRight3, TWO_PI*4, 0.01);
    strokeWeight(8);
    stroke(255);
    noFill();


    cut2 = lerp(cut2, 0, 0.01);
    cut = lerp(cut, TWO_PI/2, 0.01);

    if (arcRadiusX<width) {
      arcRadiusX += 10;
      arcRadiusY += 10;
    }
    stroke(255);
    arc(width/2, height/2, arcRadiusX, arcRadiusY, arcDirRight3-cut2, arcDirRight3-cut); // right arc that cuts out
    arc(width/2, height/2, arcRadiusX, arcRadiusY, PI+arcDirRight3-cut2, PI+arcDirRight3-cut); // left arc that cuts out
    noStroke();
  }



  // serie di archi concentrici
  if (arcRadiusX>=width/6) {
    noFill();
    strokeWeight(10);
    stroke(255);

    float target2 = TWO_PI - radians(x);
    y += 7;
    x += target2 * 4;
    arc(width/2, height/2, width/1.8, width/1.8, radians(y), radians(x));


    fill(206, 68, 237);
    noStroke();
    endAngle = lerp(endAngle, HALF_PI*3, 0.06);
    arc(width/2, height/2, width/4, width/4, -HALF_PI, endAngle); // cerchio interno
  }


  if (y>14) {
    noFill();
    strokeWeight(10);
    stroke(255, 178, 249);
    float target1 = 90 + z;
    if (z>-90)
      z -= target1 * 0.04;

    arc(width/2, height/2, width/3, width/3, radians(z), HALF_PI*3);
  }


  if (y>100) {
    noFill();
    strokeWeight(30);
    stroke(255, 246, 84);

    float target3 = TWO_PI+HALF_PI - radians(g);
    f += 3.5;
    g += target3 * 2;
    arc(width/2, height/2, width/3.5, width/3.5, HALF_PI+radians(f), radians(g));
  }


  if (y>200) {
    noFill();
    strokeWeight(15);
    stroke(255, 143, 84);
    float target3 = PI+HALF_PI - radians(i);
    h += 3.7;
    i += target3 * 2;
    arc(width/2, height/2, width/2.7, width/2.7, -HALF_PI+radians(h), radians(i));
  }


  if (y>1200) {
    float target3 = 96 - textsize;
    textsize += target3 * 0.2;
    uncle = createFont("unclbm.ttf", textsize);

    float target4 = 660 - linesize;
    linesize += target4 * 0.15;

    fill(255, 255, 255);
    textFont(uncle);
    textAlign(CENTER);
    stroke(0);
    strokeWeight(5);
    text("Canale", width/2, height/2);
    textAlign(CENTER, TOP);
    text("31", width/2, height/2);
    translate(width/2, height/2);
    for (int i = 0; i < 50; i++) {
      rotate(radians(360.0/50)); 
      stroke(255, 255, 255);
      strokeWeight(20);
      line(m, 0, linesize, 0);
    }
  }
}
