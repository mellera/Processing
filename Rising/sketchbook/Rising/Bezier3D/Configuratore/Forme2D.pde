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