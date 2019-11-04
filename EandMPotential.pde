
void setup(){
 size(700, 700);
 background(255);

}

void draw(){
 background(255); 
  stroke(0); 
  strokeWeight(4); 
  line(width/2 - 200, height/2 - 200, width/2 - 200, height/2 + 200); 
  line(width/2 - 200, height/2 - 200, width/2 + 200, height/2 - 200);
  
  float test = map(mouseX, 0, width, 0, 1); 
  println(test); 
  float max = 0; 
  
  int N = 200; 
  for(int i = 0; i < N; i++){
   for(int j = 0; j < N; j++){
     float dx = map(i, 0, N, 0, 1); 
     float dy = map(j, 0, -N, 0, 1); 
     
     float Vxy = potential(dx, dy); 
     
     if(Vxy > max) max = Vxy;
     
     if(approx(Vxy, test)){ 
       fill(0); 
       noStroke(); 
       ellipse(map(i, 0, N, 0, 300) +width/2 - 198, map(j, 0, N, 0, 300) + height/2 - 198,8,8);  
     }
     if(Vxy != test){
       fill(map(Vxy, 0, 1, 0, 255), 153, 153); 
       noStroke();
       ellipse(map(i, 0, N, 0, 300)+width/2 - 198, map(j, 0, N, 0, 300) + height/2 - 198,4,4); 
     }
    
   }
  }
  stroke(0); 
  
  println("MAX=  " + max); 
}

float potential(float x, float y){
 float V = 0; 
 
 for(int i = 0; i < 10; i++){
  float k = (4*cosh((2*i+1)*PI * y) * sin((2*i+1)*PI*x)) / ((2*i+1) *PI * cosh((2*i+1)*PI));
  V += k; 
 }
 return V;  
}

float cosh(float x){
 return .5*(exp(x) +exp(-x)); 
}

boolean approx(float a, float b){
  boolean buul = true;
  if(abs(a - b) < 0.0008) buul = true; 
  if(abs(a - b) > 0.0008) buul = false;  
  return buul;
}