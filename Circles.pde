

void setup(){
 size(600, 600); 
 background(255); 
}

void draw(){
  background(255); 
  float rad = 350; 
 
  pushStyle(); 
    PVector closest = new PVector(width/2 + .5*rad*cos(atanb(mouseX - width/2, mouseY - height/2)), 
                                  height/2 + .5*rad*sin(atanb(mouseX - width/2, mouseY - height/2))); 
                                  
    float d = dist(mouseX, mouseY, closest.x, closest.y); 
    PVector mid = new PVector ((mouseX + closest.x)/2, (mouseY + closest.y)/2);
  popStyle(); 
  
  pushStyle(); 
    noFill(); 
    stroke(153, 153, 153, 153); 
    strokeWeight(10); 
    ellipse(width/2, height/2, rad, rad); 
    ellipse(mid.x, mid.y, d, d); 
  popStyle(); 
  
}

float atanb(float x, float y){
 float theta = 0; 
  
 if(x > 0) theta = atan(y/x);
 if(x < 0 && y >= 0) theta = atan(y/x) + PI; 
 if(x < 0 && y < 0) theta = atan(y/x) - PI; 
 if(x == 0 && y > 0) theta = PI/2; 
 if(x == 0 && y > 0) theta = -PI/2; 
  
 return theta; 
}