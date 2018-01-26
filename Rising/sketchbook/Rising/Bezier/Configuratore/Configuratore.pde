import processing.net.*;

Server s;

Poltrona Giorgio;

Punto a, b, c, d, e, f, g, h;
Linea i, l, m, n;
Curva o, p;

Punto[] punti = new Punto[8];
Linea[] linee = new Linea[4];
Curva[] curve = new Curva[2];

int x1 = 770, x2 = 619, lunghezza = 1650;

void setup() {
  size(1900, 1000); 
  stroke(255);
  noFill();
  
  a = new Punto(1015, 0);
  b = new Punto(1306, 306);
  c = new Punto(1015, 925);
  d = new Punto(1306, 619);
  e = new Punto(1015, 0);
  f = new Punto(770, 306);
  g = new Punto(1015, 925);
  h = new Punto(770, 619);
  
  i = new Linea(a, b);
  l = new Linea(c, d);
  m = new Linea(e, f);
  n = new Linea(g, h);
  
  o = new Curva(i, l);
  p = new Curva(m, n);
  
  Giorgio = new Poltrona(o, p);
  
  s = new Server(this, 12345);
}

void draw() { 
  
  if(mousePressed) {
    background(0);
    
    translate(0, 37);
    
    i = new Linea(a, b);
    l = new Linea(c, d);
    m = new Linea(e, f);
    n = new Linea(g, h);
    
    o = new Curva(i, l);
    p = new Curva(m, n);
    
    Giorgio.Configura(o, p);
    
    Giorgio.Disegna();
    
    stroke(255,0,0);
    line(lunghezza,0,lunghezza,1000);    
  }
  
}

boolean InterpretaStringa(String _s) {
  if(_s.indexOf("\n") >= 0) {      
    _s = _s.substring(0, _s.indexOf("\n"));
    
    int[] data = int(split(_s, ' '));
    
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
        
      return true;        
    }
  }
    
  return false;  
}

void OttieniConfigurazione() {
  String[] linee = loadStrings("configurazione.txt");  
  
  boolean c = InterpretaStringa(
}

void SalvaConfigurazione(String string) {
  PrintWriter output;
  output = createWriter("configurazione.txt");
  output.println(string + " " + lunghezza + "\n");
  output.flush();
  output.close(); 
}

void InviaConfigurazione(String string) {
  s.write(string + " " + lunghezza + "\n");
}