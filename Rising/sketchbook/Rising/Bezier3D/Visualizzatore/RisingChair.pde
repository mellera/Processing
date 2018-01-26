class RisingChair { 
  
  Coppia[] assi = new Coppia[37];
  
  int[] misure = new int[37];
 
  int lunghezza = 1500; 
  
  int n_assi = 37;
  
  int lato = 25;
  
  Curva a;
  Curva b;
    
  RisingChair() {}
  
  RisingChair(RisingChair _configurazione) {
    this.CaricaConfigurazione(_configurazione);
  }
  
  RisingChair(Curva _a, Curva _b, int _lunghezza) {
    this.Configura(_a, _b, _lunghezza);  
  }
  
  void CaricaConfigurazione(RisingChair _configurazione) {
    this.Configura(_configurazione.a, _configurazione.b, _configurazione.lunghezza);
  }
  
  void Configura(Curva _a, Curva _b, int _lunghezza) {
    this.a = new Curva(_a);
    this.b = new Curva(_b);
    
    this.lunghezza = _lunghezza;
    
    this.Costruisci();
  }
  
  void DisegnaPiatta() {
    for(int i = 0; i < this.n_assi; i++) {
      Coppia f = new Coppia(this.assi[i].lunghezza_effettiva, this.assi[i].lunghezza_effettiva_primo, (i * this.lato), this.lato);
      f.DisegnaPiatta();
    }  
  }
 
  void Disegna(int _x) {  
    for(int i = 0; i < this.n_assi; i++) {
      if((i) == 0 || i == this.n_assi-1) stroke(255, 0, 0); else stroke(255);
      this.assi[i].Disegna(_x); 
    }
  }
  
  private void Costruisci() {
    this.CreaArray();    
    this.CreaCoppie();
  }
  
  private void CreaCoppie() {    
    for(int i = 0; i < this.n_assi; i++) {
      this.assi[i] = new Coppia(this.lunghezza, misure[i], ( i * this.lato ) + i, this.lato); // modificare (i* this.lato) in (i*this.lato)+i per avere gli assi separati
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
      
      if( (i % 2) == 0 ) c = 'a'; else c = 'b';      
      
      misure[i] = this.GetX((i * this.lato) + correzione, c);
    }
  }
  
  private int GetX(float y, char c) {
    int result;
    
    if( c == 'a' ) {
      result = this.GetMisura(y, this.b);
    } else {
      result = this.GetMisura(y, this.a);
    }
    
    return result;    
  }
  
  private int GetMisura(float y, Curva _a) {    
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