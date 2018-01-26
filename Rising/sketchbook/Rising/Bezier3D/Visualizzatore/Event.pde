void keyPressed() {  
  if(key == 'p') {
    x += 20;
    println(x);
    disegna = true;
  }
  
  if(key == 'l') {
    x -= 20;
    println(x);
    disegna = true;
  }
  
  if(key == 'x') {
    modalita = !modalita; 
    disegna = true;
  }
  
  if(key == 'm') {
    camera.reset();  
  }
  
  if(key == 'r') {
    record = 1;
  }
  
  if(key == 't') {
    record = 2;
  }
  
}