
Vertex[] matrix = new Vertex[16];
PVector matrixPos;
float matrixSize = 260; 

StringList twoAddresses = new StringList(); 
StringList nAddresses = new StringList(); 



void setup(){
 background(255); 
 size(900, 900); 
 //fullScreen(); 
 
 rectMode(CENTER);

 matrixPos = new PVector(width/2 + 15, height/2 + 250); 
 
 for(int i = 0; i < matrix.length; i++){
   matrix[i] = new Vertex(); 
   matrix[i].type = "Button"; 
   matrix[i].MoveType = "Fixed"; 
   matrix[i].size = new PVector(60, 60); 
   matrix[i].selected = true; //floor(random(0, 2)) == 0; 
 }
 
 int count = 0;
  
 for(int i = 0; i < 4; i++){
   float mx = map(i, 0, 4, matrixPos.x - matrixSize/2, 
                           matrixPos.x + matrixSize/2); 
                           
   for(int j = 0; j < 4; j++){
   float my = map(j, 0, 4, matrixPos.y - matrixSize/2, 
                           matrixPos.y + matrixSize/2);
                           
     matrix[count % 16].position = new PVector(mx, my);
     matrix[count % 16].name = str(i) + str(j);
     count++; 
     
     nAddresses.append(str(i) + str(j)); 
     
     //if(i == j) matrix[4*i+j].selected = true; 
   }
 }
 
}

void draw(){ // *********************************************** DRAW
  background(255); 
  twoAddresses.clear();
   
  for(int i = 0; i < matrix.length; i++){
   matrix[i].run();  
   if(matrix[i].selected){
    twoAddresses.append(matrix[i].name);  
   }
  }
  
  for(String s: popString(twoAddresses, 2)){
    square P1 = new square(new PVector(width/2 - 20, height/2 - 170), 350, "");
    g(P1, s); 
  }  
  
 //PVector DIM = dim(twoAddresses, nAddresses); 
 
 //text("log(N(r)) = -" + DIM.x + " log(r) + " + DIM.y, width/2 - 200, height/2 + 300); 
 
 
}  

PVector dim(StringList A0, StringList C0){  // *********************************************** DIMENSION
  PVector result = new PVector(0, 0); 
  StringList Attractor = A0; 
  StringList Cover = C0; 
  
  
  Cover = popString(Cover, 3); 
  Attractor = popString(Attractor, 3); 
  
  int N1 = 0; 
  
  for(int i = 0; i < Cover.size(); i++){
    String p = Cover.get(i); 
    
    for(int j = 0; j < Attractor.size(); j++){
      String  q = Attractor.get(j); 
      
      if(q.equals(p)) N1++; 
    }
  }
 
  Attractor = A0; 
  Cover = C0; 
  
  Cover = popString(Cover, 4); 
  Attractor = popString(Attractor, 4); 
  
  int N2 = 0; 
  
  for(int i = 0; i < Cover.size(); i++){
    String p = Cover.get(i); 
    
    for(int j = 0; j < Attractor.size(); j++){
      String  q = Attractor.get(j); 
      
      if(q.equals(p)) N2++; 
    }
  }
  
  float dr = -3*log(2) + 4*log(2); 
  float dN = log(N1) - log(N2); 
  
  result.x = abs(dN/dr); 
  result.y = log(N1) + result.x*3*log(2); 
  return  result;
}

// *********************************************** POP STRING

StringList popString(StringList S1, int n){
 StringList S0 = new StringList(); 
 StringList temp = new StringList();
 
 String[] AS1 = new String[S1.size()];
 for(int h = 0; h < AS1.length; h++){
   AS1[h] = S1.get(h);
   S0.append(AS1[h]);
 }
 
 for(int k = 0; k < n; k++){  
  temp.clear();
   
   for(int i = 0; i < S0.size(); i++){
     String s = S0.get(i); 
     
     for(int j = 0; j < AS1.length; j++){
       String q = AS1[j]; 
       
       if(q.charAt(q.length() -2) == s.charAt(s.length() -1)){
         temp.append(s + (q.charAt(q.length() -1)));
       }
     }
   } 
   
   S0.clear(); 
   for(String p: temp) S0.append(p); 
 }
  
 return S0; 
}

void g(square S1, String N){ // *********************************************** IFS STATES, FAMILY
     square S0 = S1; 
     float theta = 0;//map(mouseX, 0, width, 0, 2*PI); 
     
     float dirX = 1; 
     float dirY = 1; 
     
     char q0 = N.charAt(0); 
   
       
       for(int i = 1; i < N.length(); i++){
         char q = N.charAt(i); 
         char p = N.charAt(i-1);
         
         theta = PI/2; 
         if(p == '0' || p == '3') theta = 0; 
         
 
         if(q == '0'){ dirX = -sqrt(3); dirY = 0;}
         if(q == '1'){ dirX = -sqrt(3)/2; dirY = -sqrt(3)/2;}
         if(q == '2'){ dirX = sqrt(3)/2; dirY = -sqrt(3)/2;}
         if(q == '3'){ dirX = sqrt(3); dirY = 0; }
         

         //translate by negative position, move to origin, 
         //rotate and scale to appropriate position
         //translate by positive position, move to where you want to display it. 
         
        
         if(p == '0' && q == '1')theta += PI/4; 
         if(p == '0' && q == '2')theta += -PI/4;
        
         if(p == '1' && q == '1')theta += PI/4; 
         if(p == '1' && q == '2')theta += -PI/2; 
         
         if(p == '2' && q == '1')theta += PI/2; 
         if(p == '2' && q == '2')theta += -PI/4; 
         
         if(p == '3' && q == '1')theta += PI/4;
         if(p == '0' && q == '2')theta += -PI/4; 
         
         S0.size /= 3;
         S0.pos.x = S0.pos.x + (dirX * S0.size)*cos(theta);
         S0.pos.y = S0.pos.y + (dirY * S0.size)*sin(theta);
 
       }
     
     stroke(0); 
     strokeWeight(2); 
     line(S0.pos.x, S0.pos.y, S0.pos.x + S0.size*cos(theta), S0.pos.y +  S0.size*sin(theta)); 
     
     //S0.disp(); 
}

class square{ // *********************************************** SQUARE CLASS
  PVector pos; 
  float size; 
  String name; 
  
  square(){
   pos = new PVector(0, 0); 
   size = 0;
   name = "";  
  }
  
  square(PVector P0, float L, String N){
    pos = P0; 
    size = L;
    name = N; 
  }
  
  void disp(){
   fill(0, 200);
   noStroke(); 
   rect(pos.x, pos.y, size*2, size*2);
  }
}

void mousePressed(){
  for(Vertex v: matrix){
   v.pressed();  
  }
}

void mouseReleased(){
  for(Vertex v: matrix){
   v.released();  
  }
}

PVector mobiusTransform(PVector P0, PVector P1,  float a){
  PVector P2 = PVector.sub(P0, P1); 
  float r = mag(P2.x, P2.y);
  float newr = pow(a/2, 2) / r; 
  
  P2.normalize(); 
  P2.mult(-newr);
  P2.add(P0); 
 
  return P2; 
}

//***************************************************************Vertex Class

class Vertex {

  PVector position; 
  PVector dPosition;
  PVector size;
  PVector sliderRange;
  PVector sliderPosition;

  boolean overVertex;
  boolean locked;
  boolean selected;
  boolean hidden; 

  float slideVal;

  String MoveType;
  String type;
  String name; 

//***************************************************************Instance

  public Vertex() {
    slideVal = 0;

    position = new PVector(random(4 * width / 5, width), random(0, height / 5));
    size = new PVector(0, 0);
    sliderRange = new PVector(0, 0);
    sliderPosition = new PVector(position.x, position.y);

    MoveType = "Normal";
    type = "Vertex";
    name = "";

    locked = false;
    selected = false;
  }
  
  public void run(){
   initiate();
   reInitiate();
  }

//***************************************************************Initiate

  public void initiate() {
    dPosition = new PVector(0, 0);
    if(type == "Slider")MoveType = "Vertical"; 
  } 

  public boolean select() {
    selected = !selected; 

    return selected;
  }

//***************************************************************Reinitiate
  public void reInitiate() {

    pushStyle();
    strokeWeight(1.5);

    if(mouseX > position.x - (.5 * size.x) && mouseX < position.x + (.5 * size.x) && 
       mouseY > position.y - (.5 * size.y) && mouseY < position.y + (.5 * size.y)) {
          
      overVertex = true;

      if(!locked){ 
        stroke(0);
        fill(153, 60);
      }
      
    }else{ // Colors and Shit for Unselected
      stroke(153);
      fill(107, 193, 218, 150);
      overVertex = false;
    }

    if(type == "Vertex") {
      ellipse(position.x, position.y, size.x, size.y);
    }
    
    if(type == "Button") {
      if(selected) { 
        stroke(0);
        strokeWeight(2);
        fill(107, 193, 218, 200);
      }
      
     if(!hidden) rect(position.x, position.y, size.x, size.y);
    }

    if (type == "Slider") {
      if(!hidden){
        fill(0);
        stroke(0); 
        text(sliderRange.y, sliderPosition.x - 15, sliderPosition.y - 85);
        text(sliderRange.x, sliderPosition.x - 15, sliderPosition.y + 92);
        line(sliderPosition.x, sliderPosition.y, sliderPosition.x, sliderPosition.y + 80);
        line(sliderPosition.x, sliderPosition.y, sliderPosition.x, sliderPosition.y - 80);
        
        fill(107, 193, 218, 200); 
        rect(position.x, position.y, size.x, size.y);
      }
      
      float slideDist = dist(position.x, position.y, sliderPosition.x, sliderPosition.y - 100);
      slideVal = (map(slideDist, 100 - (100 - .5 * size.y), 100 + (100 - .5 * size.y), sliderRange.y, sliderRange.x));
      
      name = "" + nf(slideVal, 1, 3);
    }
  


    fill(0);
    textSize(20);
    if(!hidden) text(name, position.x - (.5 * size.x) + 4, position.y + (.125 * size.y));
    popStyle();
  }

//***************************************************************Mouse Pressed
  public void pressed() {
    pushStyle();
    
    if(type == "Button") {
      if(overVertex) {
        select();
      }
    }
     
    if(type == "Vertex") {
      if(overVertex) {
        locked = true; 
        fill(153);
      }else{
        locked = false;
      } 
      dPosition = new PVector(mouseX - position.x, mouseY - position.y);
    }
     
    if(type == "Slider") {
      if(overVertex) {
        locked = true; 
        fill(153);
      }else{
        locked = false;
      } 
    }
    
    popStyle();
  }

//***************************************************************Mouse Dragged

  public void dragged(){

    if (locked) {
      if (MoveType == "Normal") {
        position = new PVector(mouseX - dPosition.x, mouseY - dPosition.y);
      }
      if (MoveType == "Horizontal") {
        position = new PVector(mouseX - dPosition.x, position.y);
      }
      if (MoveType == "Vertical") {
        position = new PVector(position.x, mouseY - dPosition.y);
        
        if(position.y < sliderPosition.y - (80 - .125 * size.y)) position.y = sliderPosition.y - (80 - .125 * size.y);
        if(position.y > sliderPosition.y + (80 - .125 * size.y)) position.y = sliderPosition.y + (80 - .125 * size.y);
      }
      if (MoveType == "Fixed") {
        //position = position;
      }
    }
  }

//***************************************************************Mouse Released

  public void released() {
    if (type == "Vertex") {
      locked = false;
    }
    if (type == "Button") {
      locked = true;
    }
  }
}