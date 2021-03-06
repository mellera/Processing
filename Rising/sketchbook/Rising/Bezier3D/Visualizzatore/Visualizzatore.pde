import peasy.*;
import processing.dxf.*;
import processing.net.*;

Client Client;

PeasyCam camera;

int record = 0;

int x = 930;

boolean modalita = true; // true visualizza la poltrona in 3D false visualizza la poltrona in piano

boolean disegna = false;

RisingChair Giorgio;
RisingChair Configurazione = null;

void setup() {
  size(1000, 900, P3D);
  
  frameRate(25);
  
  camera = new PeasyCam(this, 2000);
  camera.setMinimumDistance(500);
  camera.setMaximumDistance(4000);
  
  Client = new Client(this, "127.0.0.1", 12345);
  
  Configurazione = CaricaConfigurazioneDaFile();
  
  Giorgio = new RisingChair();
  
  if(Configurazione != null) {
    Giorgio.CaricaConfigurazione(Configurazione);
    disegna = true;
  }
  
  stroke(255);
  
}

void draw() {
  
  if (record == 1) {
    beginRaw(DXF, "data/dxf/poltrona.dxf"); 
  } else if(record == 2) {
    beginRaw(DXF, "data/dxf/misure.dxf");   
  } 
  
  Configurazione = CaricaConfigurazioneDaServer();
  
  if(Configurazione != null) {
    Giorgio.CaricaConfigurazione(Configurazione);
    disegna = true;
  }
  
  background(0);
    
  if(modalita) {
    Giorgio.Disegna(x);
  } else {
    Giorgio.DisegnaPiatta();
  }
  
  if (record != 0) {
    record = 0;
    endRaw();    
  } 
  
}

RisingChair CaricaConfigurazioneDaFile() {
  String[] linee = loadStrings("C:/ProcessingData/Bezier3D/configurazione.txt");
  return InterpretaStringa(linee[0]);
}

RisingChair CaricaConfigurazioneDaServer() {  
  if (Client.available() > 0) {    
    return InterpretaStringa(Client.readString());
  }
  return null;
}

RisingChair InterpretaStringa(String _s) {  
  if(_s.indexOf(";") >= 0) {      
    _s = _s.substring(0, _s.indexOf(";"));
    
    int[] data = int(split(_s, ' '));
    
    if(data.length >= 17) {
      
      Punto a,b,c,d,e,f,g,h;
      Linea i,l,m,n;      
        
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
      
      RisingChair result = new RisingChair(new Curva(i, l), new Curva(m, n), data[16]);
        
      return result;
    }
  }
    
  return null;  
}