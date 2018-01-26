class Punto3D {
  
  float x;
  float y;
  float z;

  Punto3D(float _x, float _y, float _z) {
    this.x = _x;
    this.y = _y;
    this.z = _z;
  }
  
  Punto3D(Punto3D p) {
    this.x = p.x;
    this.y = p.y;
    this.z = p.z;
  }
  
  void Disegna() {
    point(x, y, z);  
  }
  
  String ToString() {    
    return this.x + " " + this.y + " " + this.z;
  }
  
}

class Linea3D {
  
  Punto3D p1;
  Punto3D p2;
  
  Linea3D(Punto3D _p1, Punto3D _p2) {
    this.p1 = new Punto3D(_p1);
    this.p2 = new Punto3D(_p2);
  }
  
  Linea3D(Linea3D l) {
    this.p1 = new Punto3D(l.p1); 
    this.p2 = new Punto3D(l.p2); 
  }
  
  void Disegna() {
    line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);   
  }
  
  float GetLunghezza() {
    return sqrt(((p1.x-p2.x)*(p1.x-p2.x))+((p1.y-p2.y)*(p1.y-p2.y)));
  }
  
  String ToString() {
    return this.p1.ToString() + " " + this.p2.ToString();
  }
  
}

class Rettangolo3D {
  
  Linea3D a;
  Linea3D b;
  Linea3D c;
  Linea3D d;
  
  Rettangolo3D() {}
  
  Rettangolo3D(Linea3D _l, int _larghezza) {
    this.Configura(_l, _larghezza);
  }
  
  void Configura(Linea3D _l, int _larghezza) {    
    float inclinazione = CalcolaInclinazione3D(_l);   
    
    float delta_x, delta_y;
    
    delta_x = _larghezza * cos( radians( inclinazione + 90 ) );
    delta_y = _larghezza * sin( radians( inclinazione + 90 ) );
    
    Punto3D p3 = new Punto3D(_l.p2.x - delta_x, _l.p2.y - delta_y, _l.p1.z);
    Punto3D p4 = new Punto3D(_l.p1.x - delta_x, _l.p1.y - delta_y, _l.p1.z);
    
    this.a = new Linea3D(_l);
    this.b = new Linea3D(_l.p2, p3);
    this.c = new Linea3D(p3, p4);
    this.d = new Linea3D(p4, _l.p1);
  }
  
  void Disegna() {
    a.Disegna();
    b.Disegna();
    c.Disegna();
    d.Disegna();
  } 
  
  float GetLunghezza() {
    return a.GetLunghezza();  
  }
  
}

class Rettangolo3DModA extends Rettangolo3D {
  
  Rettangolo3DModA() {}
  
  Rettangolo3DModA(Linea3D _l, int _larghezza) {
    this.Configura(_l, _larghezza);
  }
  
  void Configura(Linea3D _l, int _larghezza) {
    float inclinazione = CalcolaInclinazione3D(_l);    
    
    float dx1 = ( _larghezza / 2 ) * cos( radians( inclinazione ) ); 
    float dx2 = ( _larghezza / 2 ) * cos( radians( inclinazione  +90 ) );
    float dy1 = ( _larghezza / 2 ) * sin( radians( inclinazione ) );
    float dy2 = ( _larghezza / 2 ) * sin( radians( inclinazione + 90 ) );    
    
    Punto3D p1 = new Punto3D(_l.p1.x - dx1 + dx2, _l.p1.y - dy1 + dy2, _l.p1.z);
    
    super.Configura(new Linea3D(p1, _l.p2), _larghezza);
  }
  
}

class Rettangolo3DModB extends Rettangolo3D {

  Rettangolo3DModB(Linea3D _l, int _larghezza) {
    this.Configura(_l, _larghezza);  
  }
  
  void Configura(Linea3D _l, int _larghezza) {
    float inclinazione = CalcolaInclinazione3D(_l);    
    
    float dx1 = ( - _larghezza / 2 ) * cos( radians( inclinazione ) ); 
    float dx2 = ( - _larghezza / 2 ) * cos( radians( inclinazione  +90 ) );
    float dy1 = ( - _larghezza / 2 ) * sin( radians( inclinazione ) );
    float dy2 = ( - _larghezza / 2 ) * sin( radians( inclinazione + 90 ) );    
    
    Punto3D p1 = new Punto3D(_l.p1.x + dx1 + dx2, _l.p1.y + dy1 + dy2, _l.p1.z);
    
    super.Configura(new Linea3D(p1, _l.p2), ( - _larghezza));  
  }
  
}

class Parallelepipedo {
  
  Rettangolo3D a,b;
  
  Linea3D l1, l2, l3, l4;
  
  Parallelepipedo() {}
  
  Parallelepipedo(Linea3D _l, int _larghezza, int _spessore) {
    a = new Rettangolo3D(_l, _larghezza);
    b = new Rettangolo3D(new Linea3D(new Punto3D(_l.p1.x, _l.p1.y, _l.p1.z + _spessore), new Punto3D(_l.p2.x, _l.p2.y, _l.p2.z + _spessore)), _larghezza);
    
    l1 = new Linea3D(a.a.p1, b.a.p1);
    l2 = new Linea3D(a.a.p2, b.a.p2);
    l3 = new Linea3D(a.c.p1, b.c.p1);
    l4 = new Linea3D(a.c.p2, b.c.p2);  
  }
  
  void Disegna() {
    a.Disegna();
    b.Disegna();
    
    l1.Disegna();
    l2.Disegna();
    l3.Disegna();
    l4.Disegna();
  }
  
  float GetLunghezza() {
    return a.GetLunghezza();  
  }
  
}

class ParallelepipedoModA extends Parallelepipedo {
  
  ParallelepipedoModA() {}
  
  ParallelepipedoModA(Linea3D _l, int _larghezza, int _spessore) {
    this.Configura(_l, _larghezza, _spessore);  
  }
  
  void Configura(Linea3D _l, int _larghezza, int _spessore) {
    a = new Rettangolo3DModA(_l, _larghezza);
    b = new Rettangolo3DModA(new Linea3D(new Punto3D(_l.p1.x, _l.p1.y, _l.p1.z + _spessore), new Punto3D(_l.p2.x, _l.p2.y, _l.p2.z + _spessore)), _larghezza);
    
    l1 = new Linea3D(a.a.p1, b.a.p1);
    l2 = new Linea3D(a.a.p2, b.a.p2);
    l3 = new Linea3D(a.c.p1, b.c.p1);
    l4 = new Linea3D(a.c.p2, b.c.p2);
  }
  
}

class ParallelepipedoModB extends Parallelepipedo {
  
  ParallelepipedoModB() {}
  
  ParallelepipedoModB(Linea3D _l, int _larghezza, int _spessore) {
    this.Configura(_l, _larghezza, _spessore);  
  }
  
  void Configura(Linea3D _l, int _larghezza, int _spessore) {
    a = new Rettangolo3DModB(_l, _larghezza);
    b = new Rettangolo3DModB(new Linea3D(new Punto3D(_l.p1.x, _l.p1.y, _l.p1.z + _spessore), new Punto3D(_l.p2.x, _l.p2.y, _l.p2.z + _spessore)), _larghezza);
    
    l1 = new Linea3D(a.a.p1, b.a.p1);
    l2 = new Linea3D(a.a.p2, b.a.p2);
    l3 = new Linea3D(a.c.p1, b.c.p1);
    l4 = new Linea3D(a.c.p2, b.c.p2);
  }
  
}