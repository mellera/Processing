import processing.net.*;

Server s;

Poltrona Giorgio;

Punto a,b,c,d,e,f,g,h;
Linea i,l,m,n;

int x1 = 770, x2 = 619, lunghezza = 1650;

void setup() {
  size(1900, 1000); 
  stroke(255);
  noFill();
  
  Giorgio = new Poltrona();
  
  InizializzaPunti(CaricaConfigurazioneDaFile());
  
  s = new Server(this, 12345);
}

void draw() { 
  
  background(0);
  
  translate(0, 37);
  
  i = new Linea(a, b);
  l = new Linea(c, d);
  m = new Linea(e, f);
  n = new Linea(g, h);
  
  Giorgio.Configura(new Curva(i, l), new Curva(m, n), lunghezza);
  
  Giorgio.Disegna();
  
}

Poltrona CaricaConfigurazioneDaFile() {
  String[] linee = loadStrings("C:/ProcessingData/Bezier3D/configurazione.txt");
  return InterpretaStringa(linee[0]);
}

Poltrona InterpretaStringa(String _s) {
  if(_s.indexOf(";") >= 0) {      
    _s = _s.substring(0, _s.indexOf(";"));
    
    int[] data = int(split(_s, ' '));
    
    if(data.length >= 17) {
      
      Punto a, b, c, d, e, f, g, h;
      Linea i, l, m, n;
        
      a = new Punto(data[0], data[1]);
      b = new Punto(data[2], data[3]);
      c = new Punto(data[4], data[5]);
      d = new Punto(data[6], data[7]);
      e = new Punto(data[8], data[9]);
      f = new Punto(data[10], data[11]);
      g = new Punto(data[12], data[13]);
      h = new Punto(data[14], data[15]);
        
      i = new Linea(a, b);
      l = new Linea(c, d);
      m = new Linea(e, f);
      n = new Linea(g, h);       
        
      return new Poltrona(new Curva(i, l), new Curva(m, n), data[16]);        
    }
  }
    
  return null;  
}

void SalvaConfigurazione(String string) {
  PrintWriter output;
  output = createWriter("C:/ProcessingData/Bezier3D/configurazione.txt");
  output.println(string);
  output.flush();
  output.close(); 
}

void InviaConfigurazione(String string) {
  s.write(string);
}

void InizializzaPunti(Poltrona _configurazione) {
  a = new Punto(_configurazione.a.l1.p1.x, _configurazione.a.l1.p1.y);
  b = new Punto(_configurazione.a.l1.p2.x, _configurazione.a.l1.p2.y);
  c = new Punto(_configurazione.a.l2.p1.x, _configurazione.a.l2.p1.y);
  d = new Punto(_configurazione.a.l2.p2.x, _configurazione.a.l2.p2.y);
  e = new Punto(_configurazione.b.l1.p1.x, _configurazione.b.l1.p1.y);
  f = new Punto(_configurazione.b.l1.p2.x, _configurazione.b.l1.p2.y);
  g = new Punto(_configurazione.b.l2.p1.x, _configurazione.b.l2.p1.y);
  h = new Punto(_configurazione.b.l2.p2.x, _configurazione.b.l2.p2.y);
}