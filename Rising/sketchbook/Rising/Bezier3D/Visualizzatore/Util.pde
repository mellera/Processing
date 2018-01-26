float CalcolaInclinazione3D(Linea3D l) {
  float inclinazione;
    
  if(l.p2.x > l.p1.x) {
    inclinazione = degrees( atan( ( l.p2.y - l.p1.y ) / ( l.p2.x - l.p1.x ) ) );      
    if(inclinazione < 0) {
      inclinazione = map(inclinazione, -90, 0, 270, 360);  
    }      
  } else if(l.p2.x < l.p1.x) {
    inclinazione = map( degrees( atan( ( l.p2.y - l.p1.y ) / ( l.p2.x - l.p1.x ) ) ), 90, -90, 270, 90);      
  } else {
    if(l.p1.y > l.p2.y) {
      inclinazione = 270;  
    } else if(l.p1.y < l.p2.y) {
      inclinazione = 90;  
    } else {
      inclinazione = 0;  
    }
  }
    
  return inclinazione;
}

float CalcolaInclinazione(Linea l) {
  float inclinazione;
    
  if(l.p2.x > l.p1.x) {
    inclinazione = degrees( atan( ( l.p2.y - l.p1.y ) / ( l.p2.x - l.p1.x ) ) );      
    if(inclinazione < 0) {
      inclinazione = map(inclinazione, -90, 0, 270, 360);  
    }      
  } else if(l.p2.x < l.p1.x) {
    inclinazione = map( degrees( atan( ( l.p2.y - l.p1.y ) / ( l.p2.x - l.p1.x ) ) ), 90, -90, 270, 90);      
  } else {
    if(l.p1.y > l.p2.y) {
      inclinazione = 270;  
    } else if(l.p1.y < l.p2.y) {
      inclinazione = 90;  
    } else {
      inclinazione = 0;  
    }
  }
    
  return inclinazione;
}