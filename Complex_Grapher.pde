import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
PeasyCam cam; 

float maxMag = 200; 
void setup(){
 size(600, 600, P3D); 
 background(255); 
 
  cam = new PeasyCam(this, 600);
}

void draw(){
  background(255); 
  lights(); 
  drawAxis( new PVector(200, 200), new PVector(8, 8), 100); 
  
}



void drawAxis(PVector S0, PVector V0, int res){
 //stroke(0); 
 strokeWeight(3); 
 line(-100, 0, 0, 100, 0, 0); 
 
 pushStyle(); 
 //colorMode(HSB, 100); 
 for(int i = 0; i < res; i++){
   float dx = map(i, 0, res, -S0.x, S0.x); 
   float vx = map(dx, -S0.x, S0.x, -V0.x, V0.x); 
 
 for(int j = 0; j < res; j++){
   float dy = map(j, 0, res, -S0.y, S0.y); 
   float vy = map(dx, -S0.y, S0.y, -V0.y, V0.y); 
   
   complex v = new complex(vy, vx); 
   
   /*
   v = power(v, 3); 
   v = reciprocal(v);
   v = cotangent(v);
   */
   
   v = tanh(multiply(ln(v), e(v))); 
   v = tanh(ln(v));
   v= ln(v);
   
   stroke(255, 0, 0); 
   strokeWeight(3); 
   
   
   float mag = magnitude(v); 
   float theta = arg(v); 
   point(dx, dy + 100*mag*cos(theta), 100*mag*sin(theta)); 
   beginShape(LINES);
   fill(0);
   stroke(0);
   strokeWeight(1);
   vertex(dx, dy, 0); 
   vertex(dx, dy+100*mag*cos(theta), 100*mag*sin(theta));
   endShape();
   
  }
 }
 popStyle();
}
void drawPlane(PVector S0, PVector V0, int res){
 //C0 center
 //S0 size
 //V0 complex to span
 //res is number of dots 
 complex v = new complex(V0.x, V0.y); 
 
 pushStyle(); 
 colorMode(HSB, 100);
 
 strokeWeight(3); 
 for(int i = 0; i < res; i++){
   float dx = map(i, 0, res, -S0.x, S0.x); 
   float vx = map(dx, -S0.x, S0.x, -V0.x, V0.x); 
   
   for(int j = 0; j < res; j++){
     float dy = map(j, 0, res, -S0.y, S0.y); 
     float vy = map(dy, -S0.y, S0.y, -V0.y, V0.y); 
     
     complex z = new complex(vx, vy); 
     z = ln(e(square(z))); 
     float argz = arg(z); 
     float absz = magnitude(z); 
     
     
     stroke(map(argz, -PI, PI, 0, 100), 100, 100);
     strokeWeight(5);
     point(dx, dy, absz); 
   }
 }
 popStyle();
 
}

void drawVectors(PVector S0, PVector V0, int res){
 //C0 center
 //S0 size
 //V0 complex to span
 //res is number of dots 
 //complex v = new complex(V0.x, V0.y); 
 
 pushStyle(); 
 colorMode(HSB, 100);
 
 strokeWeight(5); 
 for(int i = 0; i < res; i++){
   float dx = map(i, 0, res, -S0.x, S0.x); 
   float vx = map(dx, -S0.x, S0.x, -V0.x, V0.x); 
   
   for(int j = 0; j < res; j++){
     float dy = map(j, 0, res, -S0.y, S0.y); 
     float vy = map(dy, -S0.y, S0.y, -V0.y, V0.y); 
     
     complex z0 = new complex(vx, vy); 
     complex z = ln(e(z0)); 
     float argz = arg(z); 
     float absz = magnitude(z); 
     
     float cx = map(z.real, -V0.x, V0.x, -S0.x, S0.x);  
     float cy = map(z.imag, -V0.y, V0.y, -S0.y, S0.y);  
     
     
     stroke(map(argz, -PI, PI, 0, 100), 100, 100); 
     //point(dx, dy, absz); 
     line(dx, dy, 0, cx, cy, absz); 
     //println(argz); 
   }
 }
 popStyle();
 
}