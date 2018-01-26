import peasy.*;
import processing.dxf.*;
import processing.net.*;

Client Client;

boolean record = false;

boolean ho_configurazione = false;

int y = 930, lunghezza = 1650;

Punto a, b, c, d, e, f, g, h;
Linea i, l, m, n;
Curva o, p;

RisingChair Giorgio;

PeasyCam camera;

void setup() {
  size(1000, 900, P3D);
  
  frameRate(25);
  
  camera = new PeasyCam(this, 2000);
  camera.setMinimumDistance(500);
  camera.setMaximumDistance(4000);
  
  Client = new Client(this, "127.0.0.1", 12345);
  
  Giorgio = new RisingChair();
  
}

void draw() {
  if (record == true) beginRaw(DXF, "output.dxf");  
  
  CaricaConfigurazione();  
  
  if(ho_configurazione) {
    //translate(width/2, height/2, 0);
    
    background(127);
    
    Giorgio.Configura(o, p, lunghezza);

    Giorgio.Disegna(y);
  }
  
  
  
  if (record == true) {
    endRaw();
    record = false;
  } 
}

void keyPressed() {  
  if(key == 'p') {
    y += 20;
    println(y);
  }
  
  if(key == 'l') {
    y -= 20;
    println(y);
  } 
  
  if ( key == 'R' || key == 'r' ) { record = true; }
  
}

void CaricaConfigurazione() {  
  if (Client.available() > 0) {
    String input;
    int data[];

    input = Client.readString();
    if(input.indexOf("\n") >= 0) {      
      input = input.substring(0, input.indexOf("\n"));
      data = int(split(input, ' '));
    
      if(data.length >= 17) {
        
        a = new Punto(data[0], data[1]);
        b = new Punto(data[2], data[3]);
        c = new Punto(data[4], data[5]);
        d = new Punto(data[6], data[7]);
        e = new Punto(data[8], data[9]);
        f = new Punto(data[10], data[11]);
        g = new Punto(data[12], data[13]);
        h = new Punto(data[14], data[15]);
        
        lunghezza = data[16];
        
        i = new Linea(a, b);
        l = new Linea(c, d);
        m = new Linea(e, f);
        n = new Linea(g, h);
        
        o = new Curva(i, l);
        p = new Curva(m, n);        
        
        ho_configurazione = true;
        
      }
    }
  }
}

class RisingChair { 
  
  Coppia[] assi = new Coppia[37];
  
  int[] misure = new int[37];
 
  int lunghezza = 1500; 
  int n_assi = 37;
  int lato = 25;
  
  Curva a;
  Curva b;
    
  RisingChair() { }
  
  RisingChair(Curva _a, Curva _b, int _lunghezza) {
    this.Configura(_a, _b, _lunghezza);  
  }
  
  void Configura(Curva _a, Curva _b, int _lunghezza) {
    this.a = new Curva(_a);
    this.b = new Curva(_b);
    
    this.lunghezza = _lunghezza;
    
    this.Costruisci();
  }
 
  void Disegna(int _y) {  
    for(int i = 0; i < this.n_assi; i++) {
      if((i%2) == 0) stroke(255,0,0); else stroke(0,0,255);
      this.assi[i].Disegna(_y); 
    }
  }
  
  private void Costruisci() {
    this.CreaArray();    
    this.CreaCoppie();
  }
  
  private void CreaCoppie() {    
    for(int i = 0; i < this.n_assi; i++) {
      this.assi[i] = new Coppia(this.lunghezza, this.lato, misure[i], ( i * this.lato ));
    }   
  }
  
  private void CreaArray() {
    for(int i = 0; i < this.n_assi; i++) {
      float correzione = 0;
      if(i == ((int) (this.n_assi / 2) + 1)) {
        correzione = (float) this.lato / 2;  
      }
      if(i > ((int) (this.n_assi / 2) + 1)) {
        correzione = this.lato;  
      }      
      
      char c;
      if( (i % 2) == 0 ) c = 'a';
      else c = 'b';
      
      misure[i] = this.GetX((i * this.lato) + correzione, c);
    }
  }
  
  private int GetX(float y, char c) {
    int result;
    
    if( c == 'a' ) {
      result = GetMisura(y, this.b);
    } else {
      result = GetMisura(y, this.a);
    }
    
    return result;    
  }
  
}

int GetMisura(float y, Curva _a) {    
  float yTollerance = 0.0001;  
  float lower = 0;
  float upper = 1;
  float percent = (upper + lower) / 2;
    
  float calc_y = bezierPoint(_a.l1.p1.y, _a.l1.p2.y, _a.l2.p2.y, _a.l2.p1.y , percent); 
    
  while(abs(y - calc_y) > yTollerance) {
    if(y > calc_y) 
      lower = percent;
    else 
      upper = percent;
  
    percent = (upper + lower) / 2;
      
    calc_y = bezierPoint(_a.l1.p1.y, _a.l1.p2.y, _a.l2.p2.y, _a.l2.p1.y, percent);
  }
    
  return (int) bezierPoint(_a.l1.p1.x, _a.l1.p2.x, _a.l2.p2.x, _a.l2.p1.x, percent);
}

class Coppia {
 
  float l1;
  float l2;
  float tras_x;
  float larghezza;
  
  Coppia(float altezza_poltrona, float _larghezza, float l, float _tras_x) {
    this.l2 = l;
    this.l1 = altezza_poltrona - this.l2;
    this.tras_x = _tras_x;
    this.larghezza = _larghezza;
  }
  
  void Disegna(float _y) {
    float y1 = this.CalcolaY(_y);
    float z1 = this.CalcolaZ(_y);
    
    rettangolo(_y, 0, y1, z1);
    rettangolo(0, 0, y1, z1);
  }
  
  private void rettangolo(float y1, float z1, float y2, float z2) {
    float x8 = this.tras_x;
    float x9 = this.tras_x + this.larghezza;
    
    line(x8, y1, z1, x8, y2, z2);
    line(x8, y2, z2, x9, y2, z2);
    line(x9, y2, z2, x9, y1, z1);
    line(x9, y1, z1, x8, y1, z1);
  }
  
  private float CalcolaY(float _y) {    
    return ( (_y * _y) - (this.l1 * this.l1) + (this.l2 * this.l2) ) / ( 2 * _y );
  }
  
  private float CalcolaZ(float _y) {    
    return - sqrt( (this.l2 * this.l2) - ( ( ( (_y * _y) - (this.l1 * this.l1) + (this.l2 * this.l2) ) * ( (_y * _y) - (this.l1 * this.l1) + (this.l2 * this.l2) ) ) / ( 4 * _y * _y ) ));
  }
  
}

class Curva {
  
  public Linea l1;
  public Linea l2;
  
  Curva(Linea _l1, Linea _l2) {
    this.l1 = new Linea(_l1);
    this.l2 = new Linea(_l2);
  }
  
  Curva(Curva c) {
    this.l1 = new Linea(c.l1);
    this.l2 = new Linea(c.l2);
  }
  
  void Disegna() {
    bezier(this.l1.p1.x, this.l1.p1.y, this.l1.p2.x, this.l1.p2.y, this.l2.p2.x, this.l2.p2.y, this.l2.p1.x, this.l2.p1.y);
    this.l1.Disegna();
    this.l2.Disegna();
  }
  
  String ToString() {
    return this.l1.ToString() + " " + this.l2.ToString();  
  }
  
}

class Linea {
  
  public Punto p1;
  public Punto p2;
  
  Linea(Punto _a, Punto _b) {
    this.p1 = new Punto(_a.x, _a.y);
    this.p2 = new Punto(_b.x, _b.y);
  }
  
  Linea(Linea l) {
    this.p1 = new Punto(l.p1);
    this.p2 = new Punto(l.p2);
  }
  
  void Disegna() {
    line(this.p1.x, this.p1.y, this.p2.x, this.p2.y);      
  }
  
  String ToString() {
    return this.p1.ToString() + " " + this.p2.ToString();
  }

}

class Punto {
  
  public int x;
  public int y;
  
  Punto(int _x, int _y) {
    this.x = _x;
    this.y = _y;
  }
  
  Punto(Punto p) {
    this.x = p.x;
    this.y = p.y;
  }
  
  void Disegna() {
    point(this.x, this.y);  
  }
  
  String ToString() {
    return this.x + " " + this.y;  
  }

}