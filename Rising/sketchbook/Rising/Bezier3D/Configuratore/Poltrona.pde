
class Poltrona {
  
  Curva a;
  Curva b;
  
  int lunghezza;
  
  int[] misure = new int[37];
  
  int n_assi = 37;
  int lato = 25;
  
  Poltrona() {}
  
  Poltrona(Curva _a, Curva _b, int _lunghezza) {
    this.Configura(_a, _b, _lunghezza);  
  }
  
  public void Configura(Curva _a, Curva _b, int _lunghezza) {
    this.a = new Curva(_a);
    this.b = new Curva(_b);
    
    this.lunghezza = _lunghezza;
    
    this.Costruisci();
  }
  
  public void Disegna() {    
    for(int i = 0; i < this.n_assi; i++) {  
      fill(0,255,0);
      rect(0, i * this.lato, misure[i], this.lato);     
    }
    noFill();
    this.a.Disegna();
    this.b.Disegna();
    
    stroke(255, 0, 0);
    line(this.lunghezza, 0, this.lunghezza, 1000);
  }
  
  String GetConfigurazione() {
    return this.a.ToString() + " " + this.b.ToString() + " " + this.lunghezza + ";";  
  }
  
  private void Costruisci() {
    this.CreaArray();
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
  
}