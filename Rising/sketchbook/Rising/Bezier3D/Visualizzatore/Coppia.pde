class Coppia {
 
  int l1;
  int l2; 
  int z;
  int larghezza;
  int lunghezza_effettiva;
  int lunghezza_effettiva_primo;
  
  Coppia(int _lunghezza, int _l, int _z, int _larghezza) {
    this.l2 = _l;
    this.l1 = _lunghezza - this.l2;
    this.z = _z;
    this.larghezza =_larghezza;
  }
  
  void DisegnaPiatta() {
    Linea3D li1 = new Linea3D(new Punto3D(0, 0, this.z), new Punto3D(this.l1, 0, this.z));
    Linea3D li2 = new Linea3D(new Punto3D(this.l1, 0, this.z), new Punto3D(this.l1 + this.l2, 0, this.z));
    
    Parallelepipedo a = new Parallelepipedo(li1, this.larghezza, this.larghezza);
    Parallelepipedo b = new Parallelepipedo(li2, this.larghezza, this.larghezza);
    
    a.Disegna();
    b.Disegna();
  }
  
  void Disegna(int _x) {
    float x = this.CalcolaX(_x);
    float y = this.CalcolaY(_x);
    
    Linea3D li1 = new Linea3D(new Punto3D(0, 0, this.z), new Punto3D(x, y, this.z));
    Linea3D li2 = new Linea3D(new Punto3D(_x, 0, this.z), new Punto3D(x, y, this.z));
    
    ParallelepipedoModA a = new ParallelepipedoModA(li1, this.larghezza, this.larghezza);
    ParallelepipedoModB b = new ParallelepipedoModB(li2, this.larghezza, this.larghezza);
    
    this.lunghezza_effettiva_primo = (int) a.GetLunghezza();
    this.lunghezza_effettiva = (int) b.GetLunghezza() + this.lunghezza_effettiva_primo;
    
    a.Disegna();
    b.Disegna();
  }
  
  private float CalcolaX(float _x) {
    return ( (_x * _x) - (this.l1 * this.l1) + (this.l2 * this.l2) ) / ( 2 * _x );
  }
  
  private float CalcolaY(float _x) {    
    return - sqrt( (this.l2 * this.l2) - ( ( ( (_x * _x) - (this.l1 * this.l1) + (this.l2 * this.l2) ) * ( (_x * _x) - (this.l1 * this.l1) + (this.l2 * this.l2) ) ) / ( 4 * _x * _x ) ));
  }
  
}