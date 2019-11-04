PImage redot, rupee, sym; 

PFont font; 
int textSize; 

float theta = 0; 

void setup(){
  size(250, 250, P3D); 
  background(255);
  
  redot = loadImage("redot.png"); 
  rupee = loadImage("rupee.png"); 
  sym = loadImage("revolvIcon.png"); 
  sym.resize(int(sym.width*.3), int(sym.height*.3)); 
  rupee.resize(int(rupee.width*.15), int(rupee.height*.15)); 
  imageMode(CENTER); 
}

void draw(){
  if(theta <= 2*PI){
    background(255);
    ambientLight(255, 255, 255);   
    theta += 0.03; 
    
    pushMatrix();
    translate(width/2, height/2); 
    rotateY(theta); 
    drawCylinder(50, 100, 20);
    popMatrix();
    
    saveFrame("test/token_####.png"); 
  }
}

void drawCylinder( int sides, float r, float h){
 fill(150, 246, 242);
  stroke(0); 
  strokeWeight(5); 
  
  pushMatrix();
  
  translate(0, 0, -h/2);
  rotateY(PI); 
  ellipse(0, 0, 2*r, 2*r); 
  translate(0, 0, 0.1); 
  
  pushStyle(); 
  //fill(0); 
  //textAlign(CENTER); 
  //textSize(120); 
  //image(rupee, 0, -35); 
  //popStyle(); 
  image(sym, 0, 0); 
  popMatrix();
  
  pushMatrix();
  translate(0, 0, h/2);
  ellipse(0, 0, 2*r, 2*r); 
  translate(0, 0, 0.1); 
   image(redot, 0, 0); 
  popMatrix();
  
  for(int i = 0; i < sides; i++){
    float theta = map(i, 0, sides, 0, 2*PI); 
    float nextTheta = map(i + 1, 0, sides, 0, 2*PI);
    beginShape(); 
    stroke(0, 0); 
    vertex(r*cos(theta), r*sin(theta), h/2); 
    vertex(r*cos(nextTheta), r*sin(nextTheta), h/2); 
    vertex(r*cos(nextTheta), r*sin(nextTheta), -h/2);
    vertex(r*cos(theta), r*sin(theta), -h/2); 
    endShape(); 
  }
  
  
} 