void keyPressed() { 
  
  if(key == 'i') {
    InviaConfigurazione(Giorgio.GetConfigurazione());    
  }
  
  if(key == 'h') {
    SalvaConfigurazione(Giorgio.GetConfigurazione());  
  }
  
  if(key == 'l') {
    if(mousePressed) {
      lunghezza += mouseX - pmouseX;
      
      if (lunghezza > 1750) lunghezza = 1750;
      
      println(lunghezza);
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  }
  
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
  
  if(key == 'd') {
    if(mousePressed) {
      a.x += (mouseX - pmouseX) * 2;
      b.x += (mouseX - pmouseX) * 2;
      c.x += (mouseX - pmouseX) * 2;
      d.x += (mouseX - pmouseX) * 2;
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  }
  
  if(key == 'a') {
    if(mousePressed) {
      e.x += (mouseX - pmouseX) * 2;
      f.x += (mouseX - pmouseX) * 2;
      g.x += (mouseX - pmouseX) * 2;
      h.x += (mouseX - pmouseX) * 2; 
      
      InviaConfigurazione(Giorgio.GetConfigurazione());
    }
  }
  
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
  
  if(key == 'r') {
    a = new Punto(0, 0);
    b = new Punto(300, 0);
    c = new Punto(0, 925);
    d = new Punto(300, 925);
    e = new Punto(0, 0);
    f = new Punto(-300, 0);
    g = new Punto(0, 925);
    h = new Punto(-300, 925);
  }
}