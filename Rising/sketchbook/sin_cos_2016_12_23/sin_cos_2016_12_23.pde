float t = 0;

void setup() {
  size(960, 1000);
  
  colorMode(HSB);
  
  strokeWeight(2);

  background(0);
  
}

void draw() {
  background(0);
  
  translate(width/2, height/2);
  
  for(float i = 0; i < 90; i++) {
    stroke(255 - int (i * 2.84), 255, 255);
    
    //line(x1(t + i), y1(t + i), x2(t + i), y2(t + i));
    
    noFill();
    
    bezier(x1(t + i), y1(t + i), x2(t + i), y2(t + i), x3(t + i), y3(t + i), x4(t + i), y4(t + i)); 
    
    
  }
  
  
  
  t = t + 0.4;
}

float x1(float t) {
  return sin(t / 20) * 200;
}

float y1(float t) {
  return cos(t / 20) * 100;
}

float x2(float t) {
  return sin(t / 40) * 400 + sin(t/50) * 90;
}

float y2(float t) {
  return cos(t / 30) * 200 + cos( t / 12) * 20;
}

float x3(float t) {
  return cos(t/10) * 100;
}

float y3(float t) {
  return cos(t / 10) * 100;
}

float x4(float t) {
  return sin(t / 10) * 20 + sin(t) * 0.2;
}

float y4(float t) {
  return cos(t / 20) * 20 + cos( t / 12) * 2;
}