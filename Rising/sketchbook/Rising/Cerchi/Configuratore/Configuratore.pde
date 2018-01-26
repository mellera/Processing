import processing.net.*;

Server s;

Poltrona Giorgio;

int x_c_a = 1387, x_c_b = 666, raggio_a = 586, raggio_b = 586;

void setup() {
  size(1900, 1000);
  
  frameRate(25);
  
   s = new Server(this, 12345);
  
  Giorgio = new Poltrona(raggio_a, x_c_a, raggio_b, x_c_b);
}

void draw() {
  background(127);
  
  translate(40, 37);
  
  stroke(255, 255, 0);
  //line(1030, 0, 1030, 1000);
  
  line(1650, 0, 1650, 1000);
  
  Giorgio.Configura(raggio_a, x_c_a, raggio_b, x_c_b);
  
  Giorgio.Disegna();
}

void InviaConfigurazione() {
  s.write(raggio_a + " " + x_c_a + " " + raggio_b + " " + x_c_b + "\n");
}

void keyPressed() {
  if (key == 'q') {
    if (mousePressed) {
      raggio_a = mouseX + mouseY;  
      InviaConfigurazione();
      //println("raggio_a: ", raggio_a, " x_c_a: ", x_c_a, " raggio_b: ", raggio_b, " x_c_b: ", x_c_b);
    }
  }
  
  if (key == 'e') {
    if (mousePressed) {
      raggio_b = mouseX + mouseY; 
      InviaConfigurazione();
      //println("raggio_a: ", raggio_a, " x_c_a: ", x_c_a, " raggio_b: ", raggio_b, " x_c_b: ", x_c_b);
    }
  }
  
  if (key == 'w') {
    if (mousePressed) {
      raggio_a = mouseX + mouseY;  
      raggio_b = raggio_a;
      InviaConfigurazione();
      //println("raggio_a: ", raggio_a, " x_c_a: ", x_c_a, " raggio_b: ", raggio_b, " x_c_b: ", x_c_b);
    }
  } 
  
  if (key == 'a') {
    if (mousePressed) {
      x_c_a = mouseX + raggio_a;
      InviaConfigurazione();
      //println("raggio_a: ", raggio_a, " x_c_a: ", x_c_a, " raggio_b: ", raggio_b, " x_c_b: ", x_c_b);
    }
  }
  
  if (key == 'd') {
    if (mousePressed) {
      x_c_b = mouseX - raggio_b; 
      InviaConfigurazione();
      //println("raggio_a: ", raggio_a, " x_c_a: ", x_c_a, " raggio_b: ", raggio_b, " x_c_b: ", x_c_b);
    }
  }
  
  if (key == 's') {
    if (mousePressed) {
      int diff = x_c_a - mouseX;      
      x_c_a -= diff;
      x_c_b -= diff;   
      InviaConfigurazione();
      //println("raggio_a: ", raggio_a, " x_c_a: ", x_c_a, " raggio_b: ", raggio_b, " x_c_b: ", x_c_b);
    }
  }
  
}

class Poltrona {
  
  boolean line;
  
  int[] misure = new int[37];
 
  int n_assi = 37;
  int lato = 25;
  int raggio_a;
  int raggio_b;
  int x_c_a;
  int x_c_b;
  int y_c = (int) ((float) this.lato * (float)( (float)((float)this.n_assi) / 2));  
  
  Poltrona(int _raggio_a, int _x_c_a, int _raggio_b, int _x_c_b) {
    this.raggio_a = _raggio_a;
    this.x_c_a = _x_c_a;
    this.raggio_b = _raggio_b;
    this.x_c_b = _x_c_b;
  }
  
  void Configura(int _raggio_a, int _x_c_a, int _raggio_b, int _x_c_b) {
    this.raggio_a = _raggio_a;
    this.x_c_a = _x_c_a;
    this.raggio_b = _raggio_b;
    this.x_c_b = _x_c_b;
  }
  
  private void CreaArray() {    
    for(int i = 0; i < ( (int) ( this.n_assi / 2 ) + 1 ); i++) {   
      
      int correzione = 0;
      
      if ( i > (this.n_assi / 2) ) {
        correzione = - this.lato;
      }
      
      if ( (i % 2) == 0 ) {
        this.misure[i] = this.GetLunghezzaCorta((i * this.lato) - correzione);        
      } else {
        this.misure[i] = this.GetLunghezzaLunga((i * this.lato) - correzione);
      }    
    }
    
    for(int i = ( (int) ( this.n_assi / 2 ) + 1 ); i < this.n_assi; i++) {
      misure[i] = misure[(this.n_assi - 1 - i)];
    }    
  } 
  
  private int GetLunghezzaLunga(int z) {  
    return (int) ( this.x_c_b + sqrt( - ( this.y_c * this.y_c ) + ( 2 * this.y_c * z ) + ( this.raggio_b * this.raggio_b ) - ( z * z ) ) );
  }
  
  private int GetLunghezzaCorta(int z) {  
    return (int) ( this.x_c_a - sqrt( - ( this.y_c * this.y_c ) + ( 2 * this.y_c * z ) + ( this.raggio_a * this.raggio_a ) - ( z * z ) ) );
  }
  
  public void Disegna() {
    this.CreaArray();
    for(int i = 0; i < this.n_assi; i++) {      
      if((i%2)==0) fill(255,0,0); else fill(0,255,0);
      rect(0, i * this.lato, this.misure[i], this.lato);
      if((i%2)==0) fill(0,255,0); else fill(255,0,0);
      rect(this.misure[i], i * this.lato,  1650 - this.misure[i], this.lato);
    }
    noFill();
    ellipse(this.x_c_a, this.y_c, this.raggio_a * 2, this.raggio_a * 2);
    ellipse(this.x_c_b, this.y_c, this.raggio_b * 2, this.raggio_b * 2);
  }
  
}