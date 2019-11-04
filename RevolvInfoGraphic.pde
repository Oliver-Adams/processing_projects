import processing.video.*;
Movie coinMovie; // the spinning revolv coin movie

String[] circulated_cups; // an array which contains the number of cups circulated
String[] barcode_active; // an array which contains a 1 if the barcode is active, 0 otherwise
String[] rfid_active;   // an array which contains a 1 if the rfid reader is active, 0 otherwise

PImage deposit, enjoy, order, returnCup, ready2be, qr, icon; 
PFont font;
int textSize = 40;

float theta = 2*PI + 0.00001; 
float count = 0;
float scale = 0.5; 

float timeStamp;
Boolean startDelay = true; 

void setup(){
 size(480, 800); 
 background(255);
 font = createFont("Futura Medium.otf", textSize); 
 
 deposit = loadImage("deposit.PNG"); 
 enjoy = loadImage("enjoy.PNG"); 
 order = loadImage("order.PNG"); 
 returnCup = loadImage("return.PNG"); 
 ready2be = loadImage("ready2be.PNG"); 
 qr = loadImage("qr.PNG"); 
 icon = loadImage("revolvIcon.png");

 circulated_cups = loadStrings("circulated_cups.txt");
 barcode_active = loadStrings("barcode_active.txt"); 
 rfid_active = loadStrings("rfid_active.txt");
 
 deposit.resize(int(deposit.width*scale), int(deposit.height*scale));
 enjoy.resize(int(enjoy.width*scale), int(enjoy.height*scale));
 returnCup.resize(int(returnCup.width*scale), int(returnCup.height*scale));
 order.resize(int(order.width*scale), int(order.height*scale));
 ready2be.resize(int(ready2be.width*.8), int(ready2be.height*.8));
 qr.resize(int(qr.width*.8), int(qr.height*.8)); 
 icon.resize(int(icon.width*1), int(icon.height*1)); //icon.resize(int(icon.width*.5), int(icon.height*.5)); 
 
 coinMovie = new Movie(this, "movie.mov"); 
 coinMovie.loop(); 
 
 imageMode(CENTER); 
 textAlign(CENTER); 
}
 
void movieEvent(Movie M){
 M.read();  
}

void draw(){
 background(255);
 circulated_cups = loadStrings("circulated_cups.txt");
 barcode_active = loadStrings("barcode_active.txt"); 
 rfid_active = loadStrings("rfid_active.txt"); 
 
 PVector C0 = new PVector(width/2, 250);
 theta += 0.003;
 count += 0.01; 
 float r = 170; 
 
 
 if(barcode_active[0].equals("0") && rfid_active[0].equals("0")){
 background(255); 
 
 image(order, C0.x + r*cos(theta), C0.y + r*sin(theta)); 
 image(deposit, C0.x + r*cos(theta - PI/2), C0.y + r*sin(theta - PI/2)); 
 image(enjoy, C0.x + r*cos(theta - PI), C0.y + r*sin(theta - PI)); 
 image(returnCup, C0.x + r*cos(theta + PI/2), C0.y + r*sin(theta + PI/2)); 
 
 //image(icon, width/2, 603); 
 
 for(int i = 0; i < 4; i++){
  float eta = map(i, 0, 4, 0+PI/5.5, 2*PI+PI/5.5); 
  
  strokeWeight(10); 
  stroke(150, 246, 242);
  noFill();
  arc(C0.x, C0.y, 2*r, 2*r, theta + eta, theta + eta + PI/8); 
 }
 
 pushStyle();
   
   textSize(textSize); 
   textFont(font);
   fill(150, 246, 242);
   text("visit:", 85, height - 15); 
   fill(39, 94, 89);
   text("revolv.io\\tuck", width/2 + 85, height - 15); 
   textAlign(CENTER); 
   text(circulated_cups[0]+".", width/2, height/2 + 170); 
   fill(150, 246, 242);
   text("cups saved with revolv.", width/2, height/2 + 220); 
 popStyle();
 //saveFrame("output/infoGraphic_####.png");
 
  startDelay = true; 
 }
 
 
 if(barcode_active[0].equals("1") || rfid_active[0].equals("1")){
  
  imageMode(CENTER); 
  background(255); 
  
  if(startDelay){timeStamp = second();}
  startDelay = false; 
  
  pushMatrix(); 
  
  image(coinMovie, (theta*350)%(width+coinMovie.width/2) - coinMovie.width/4, C0.y); 
  popMatrix();
  
  pushStyle();
  textFont(font);
  textSize(textSize+20); 
  textAlign(CENTER);
  if(!rfid_active[0].equals("1")) fill(150, 246, 242); 
  if(rfid_active[0].equals("1")) fill(39, 94, 89);
  text("scan your product" , width/2, height/2+100);

  if(!barcode_active[0].equals("1")) fill(150, 246, 242); 
  if(barcode_active[0].equals("1")) fill(39, 94, 89);
  text("scan your ID ", width/2, height/2+170);
  
  if(second() > timeStamp + 1){
    if(!(barcode_active[0].equals("1") && rfid_active[0].equals("1"))) fill(255); 
    if(barcode_active[0].equals("1") && rfid_active[0].equals("1")) fill(39, 94, 89);
    text("enjoy", width/2, height/2+240);
    if(second() > timeStamp + 5)startDelay = true; 
  }
  popStyle(); 
  
  textSize(textSize); 
  textFont(font);
  fill(150, 246, 242);
  text("visit:", 85, height - 15); 
  fill(39, 94, 89);
  text("revolv.io\\tuck", width/2 + 85, height - 15); 
  
  
 }
 
 
}