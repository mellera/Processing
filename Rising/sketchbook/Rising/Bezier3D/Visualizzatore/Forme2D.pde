class Punto {
  
  public float x;
  public float y;
  
  Punto(float _x, float _y) {
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

class Rettangolo {
  
  Linea a;
  Linea b;
  Linea c;
  Linea d;
  
  int larghezza;
  
  Rettangolo() {}
  
  Rettangolo(Linea l, int _larghezza) {
    this.Configura(l, _larghezza);
  }
  
  void Configura(Linea l, int _larghezza) {
    
    this.larghezza = _larghezza;
    
    float inclinazione = CalcolaInclinazione(l);   
    
    float delta_x, delta_y;
    
    delta_x = this.larghezza * cos( radians( inclinazione + 90 ) );
    delta_y = this.larghezza * sin( radians( inclinazione + 90 ) );
    
    Punto p3 = new Punto(l.p2.x - delta_x, l.p2.y - delta_y);
    Punto p4 = new Punto(l.p1.x - delta_x, l.p1.y - delta_y);
    
    this.a = new Linea(l);
    this.b = new Linea(l.p2, p3);
    this.c = new Linea(p3, p4);
    this.d = new Linea(p4, l.p1);   
    
  }
  
  void Disegna() {
    a.Disegna();
    b.Disegna();
    c.Disegna();
    d.Disegna();
  }
  
}

class RettangoloModA extends Rettangolo {
  
  Punto a;
  
  RettangoloModA() {}
  
  RettangoloModA(Linea l, int larghezza) {
    this.Configura(l, larghezza);  
  }
  
  void Configura(Linea l, int larghezza) {
    float inclinazione = CalcolaInclinazione(l);    
    
    float dx1 = ( larghezza / 2 ) * cos( radians( inclinazione ) ); 
    float dx2 = ( larghezza / 2 ) * cos( radians( inclinazione  +90 ) );
    float dy1 = ( larghezza / 2 ) * sin( radians( inclinazione ) );
    float dy2 = ( larghezza / 2 ) * sin( radians( inclinazione + 90 ) );    
    
    Punto p1 = new Punto(l.p1.x - dx1 + dx2, l.p1.y - dy1 + dy2);
    
    super.Configura(new Linea(p1, l.p2), larghezza);  
  }
  
}

class RettangoloModB extends Rettangolo {
  
  Punto a;
  
  RettangoloModB() {}
  
  RettangoloModB(Linea l, int larghezza) {
    this.Configura(l, larghezza);  
  }
  
  void Configura(Linea l, int larghezza) {
    float inclinazione = CalcolaInclinazione(l);    
    
    float dx1 = ( - larghezza / 2 ) * cos( radians( inclinazione ) ); 
    float dx2 = ( - larghezza / 2 ) * cos( radians( inclinazione  +90 ) );
    float dy1 = ( - larghezza / 2 ) * sin( radians( inclinazione ) );
    float dy2 = ( - larghezza / 2 ) * sin( radians( inclinazione + 90 ) );    
    
    Punto p1 = new Punto(l.p1.x + dx1 + dx2, l.p1.y + dy1 + dy2);
    
    super.Configura(new Linea(p1, l.p2), ( - larghezza ) );  
  }
  
}