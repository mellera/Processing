void keyPressed() { 
  
  // forza l'invio della configurazione
  if(key == 'i') {
    InviaConfigurazione(Giorgio.GetConfigurazione());    
  }
  
  // salva la configurazione
  if(key == 'h') {
    SalvaConfigurazione(Giorgio.GetConfigurazione());  
  }
  
  // cambia la lunghezza della poltrona
  if(key == 'l') {
    if(mousePressed) {
      lunghezza += mouseX - pmouseX;
      
      if (lunghezza > 1750) lunghezza = 1750;
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  }
  
  // modifica la curva di destra
  if(key == 'e') {
    if(mousePressed) {
      b.x += (mouseX - pmouseX) * 2;
      d.x += (mouseX - pmouseX) * 2;
      b.y += (mouseY - pmouseY) * 2;
      d.y -= (mouseY - pmouseY) * 2;
      
      if(b.y>925) b.y = 925;
      if(d.y>925) d.y = 925;
      if(b.y<0) b.y = 0;
      if(d.y<0) d.y = 0; 
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  } 
  
  // modifica la curva di sinistra
  if(key == 'q') {
    if(mousePressed) {
      f.x += (mouseX - pmouseX) * 2;
      h.x += (mouseX - pmouseX) * 2;
      f.y += (mouseY - pmouseY) * 2;
      h.y -= (mouseY - pmouseY) * 2;
      
      if(f.y>925) f.y = 925;
      if(h.y>925) h.y = 925;
      if(f.y<0) f.y = 0;
      if(h.y<0) h.y = 0; 
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  }
  
  // Modifica le due curve
  if(key == 'w') {
    if(mousePressed) {
      f.x += (mouseX - pmouseX) * 2;
      h.x += (mouseX - pmouseX) * 2;
      f.y += (mouseY - pmouseY) * 2;
      h.y -= (mouseY - pmouseY) * 2;
      
      if(f.y>925) f.y = 925;
      if(h.y>925) h.y = 925;
      if(f.y<0) f.y = 0;
      if(h.y<0) h.y = 0; 
      
      b.x -= (mouseX - pmouseX) * 2;
      d.x -= (mouseX - pmouseX) * 2;
      b.y = f.y;
      d.y = h.y;
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  }
  
  // sposta la curva di destra sull'asse X
  if(key == 'd') {
    if(mousePressed) {
      a.x += (mouseX - pmouseX) * 2;
      b.x += (mouseX - pmouseX) * 2;
      c.x += (mouseX - pmouseX) * 2;
      d.x += (mouseX - pmouseX) * 2;
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  }
  
  // sposta la curva di sinistra sull'asse X
  if(key == 'a') {
    if(mousePressed) {
      e.x += (mouseX - pmouseX) * 2;
      f.x += (mouseX - pmouseX) * 2;
      g.x += (mouseX - pmouseX) * 2;
      h.x += (mouseX - pmouseX) * 2; 
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  }
  
  // Sposta le due curve sull'asse X
  if(key == 's') {
    if(mousePressed) {
      a.x += (mouseX - pmouseX) * 2;
      b.x += (mouseX - pmouseX) * 2;
      c.x += (mouseX - pmouseX) * 2;
      d.x += (mouseX - pmouseX) * 2;
      e.x += (mouseX - pmouseX) * 2;
      f.x += (mouseX - pmouseX) * 2;
      g.x += (mouseX - pmouseX) * 2;
      h.x += (mouseX - pmouseX) * 2; 
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  }
  
  if(key == 't') {
    int delta = a.x - e.x;
    a.x -= delta;
    b.x -= delta;
    c.x -= delta;
    d.x -= delta;
    
    delta = e.x - f.x;
    
    b.x = e.x + delta;
    d.x = e.x + delta;
    
    b.y = f.y;
    d.y = h.y;
    
    
  }
  
  // Resetta le forme a le ultime salvate nel file di configurazione
  if(key == 'r') {
    InizializzaPunti(CaricaConfigurazioneDaFile());
    
    InviaConfigurazione(Giorgio.GetConfigurazione());
  }
}