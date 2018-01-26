import peasy.*;
import processing.dxf.*;
import processing.net.*;

Client Client;

boolean record = false;

int x_c_a = 1295, x_c_b = 610, raggio_a = 575, raggio_b = 575, x = 1050;

int i = 0;

RisingChair Giorgio;

PeasyCam camera;

void setup() {
  size(1900, 1060, P3D);
  
  frameRate(25);
  
  camera = new PeasyCam(this, 2000);
  camera.setMinimumDistance(500);
  camera.setMaximumDistance(4000);
  
  Client = new Client(this, "127.0.0.1", 12345);
  
  Giorgio = new RisingChair(raggio_a, x_c_a, raggio_b, x_c_b);
  
}

void draw() {
  if (record == true) beginRaw(DXF, "output.dxf");  
  
  background(127);   
  
  CaricaConfigurazione();
  
  Giorgio.Configura(raggio_a, x_c_a, raggio_b, x_c_b);

  Giorgio.Disegna(x);
  
  if (record == true) {
    endRaw();
    record = false;
  } 
}

void keyPressed() {  
  if(key == 'l') {
    x += 20;
    println(x);
  }
  
  if(key == 'p') {
    x -= 20;
    println(x);
  }
  
  if ( key == 'R' || key == 'r' ) { record = true; }
  
  if(key == 'g') {
    CaricaConfigurazione();
  }
  
}

void CaricaConfigurazione() {  
  if (Client.available() > 0) {
    String input;
    int data[];

    input = Client.readString();
    if(input.indexOf("\n") >= 0) {
      input = input.substring(0, input.indexOf("\n"));
      data = int(split(input, ' '));
    
      if(data.length >= 4) {
        raggio_a = data[0];
        x_c_a = data[1];
        raggio_b = data[2];
        x_c_b = data[3];
      } 
    }         
  }  
}

class RisingChair { 
  
  Coppia[] assi = new Coppia[37];
  
  int[] misure = new int[37];
 
  int lunghezza = 1650; 
  int n_assi = 37;
  int lato = 25;
  int raggio_a;
  int raggio_b;
  int x_c_a;
  int x_c_b;
  int y_c = (int) ((float) this.lato * (float)( (float)((float)this.n_assi) / 2));  
  
  RisingChair(int _raggio_a, int _x_c_a, int _raggio_b, int _x_c_b) {
    this.raggio_a = _raggio_a;
    this.x_c_a = _x_c_a;
    this.raggio_b = _raggio_b;
    this.x_c_b = _x_c_b;
    
    this.Costruisci();
  }
  
  void Configura(int _raggio_a, int _x_c_a, int _raggio_b, int _x_c_b) {
    this.raggio_a = _raggio_a;
    this.x_c_a = _x_c_a;
    this.raggio_b = _raggio_b;
    this.x_c_b = _x_c_b;
    
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