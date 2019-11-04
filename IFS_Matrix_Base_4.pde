
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

 matrixPos = new PVector(width/2, height/2 + 250); 
 
 for(int i = 0; i < matrix.length; i++){
   matrix[i] = new Vertex(); 
   matrix[i].type = "Button"; 
   matrix[i].MoveType = "Fixed"; 
   matrix[i].size = new PVector(60, 60); 
   matrix[i].selected = floor(random(0, 2)) == 0; 
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
  
  for(String s: popString(twoAddresses, 8)){
    square P0 = new square(new PVector(width/2 - 20, height/2 - 200), 450, "");
    //square P1 = new square(new PVector(width/2 + 200, height/2 - 180), 250*sqrt(3), "");
    f(P0, s);  
    //g(P1, s); 
  }  
  
 PVector DIM = dim(twoAddresses, nAddresses); 
 
 text("log(N(r)) = -" + DIM.x + " log(r) + " + DIM.y, width/2 - 200, height/2 + 400); 
 
 
}  

PVector dim(StringList A0, StringList C0){  // *********************************************** DIMENSION
  PVector result = new PVector(0, 0); 
  StringList Attractor = A0; 
  StringList Cover = C0; 
  
  
  Cover = popString(Cover, 2); 
  Attractor = popString(Attractor, 2); 
  
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
  
  Cover = popString(Cover, 3); 
  Attractor = popString(Attractor, 3); 
  
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
  result.y = log(N1) + result.x*2*log(3); 
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

void f(square S1, String N){ // *********************************************** IFS STATES, FAMILY
     square S0 = S1; 
     
     int dirX = 1; 
     int dirY = 1; 
     
     for(int i = 2; i < N.length(); i++){
       char q = N.charAt(i); 
       
       if(q == '0'){ dirX = -1; dirY = +1; }
       if(q == '1'){ dirX = +1; dirY = +1; }
       if(q == '2'){ dirX = +1; dirY = -1; }
       if(q == '3'){ dirX = -1; dirY = -1; }
       
       S0.size /= 2; 
       S0.pos.x = S0.pos.x + (dirX * S0.size *.5);
       S0.pos.y = S0.pos.y + (dirY * S0.size *.5);
     }
     S0.disp(); 
}

void g(square S1, String N){ // *********************************************** IFS STATES, FAMILY
     square S0 = S1; 
     float theta = 0; 
     
     float dirX = 1; 
     float dirY = 1; 
     
     for(int i = 2; i < N.length(); i++){
       char q = N.charAt(i); 
       //println(theta); 
       
       if(q == '0'){ dirX = 0; dirY = 0; theta += 60; }
       if(q == '1'){ dirX = cos(radians(-330 + theta)); dirY = sin(radians(-330 + theta));}
       if(q == '2'){ dirX = cos(radians(-210 + theta)); dirY = sin(radians(-210 + theta));}
       if(q == '3'){ dirX = cos(radians(-90 + theta)); dirY = sin(radians(-90 + theta));}
       
       S0.size /= 2; 
       S0.pos.x = S0.pos.x + (dirX * S0.size *.5);
       S0.pos.y = S0.pos.y + (dirY * S0.size *.5);
     }
     
     S0.disp(); 
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
   rect(pos.x, pos.y, size, size);
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