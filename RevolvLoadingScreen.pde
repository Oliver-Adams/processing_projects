PImage revolvIcon; 
PImage leaf; 
String[] rewords = { "re.cycle", "re.volv", "re.use", "re.love", "re.claim", "re.live"}; 
PImage[] icons = new PImage[rewords.length];
PFont font; 

float[] angles = new float[rewords.length]; 


float yoffset = 0; 
float dy = 1.5; 

float textSize = 160; 


void setup(){
 size(480, 800); 
 background(255); 
 font = createFont("Futura Medium.otf", textSize);
 for(int i = 0; i < icons.length; i++){
   icons[i] = loadImage("revolvIcon.png");
   icons[i].resize(int(icons[i].width*.5), int(icons[i].height*.5)); 
   
    
   angles[i] = map(i, 0, icons.length, 2*PI, 0); 
 }
 
 leaf = loadImage("coral.jpg"); 
 leaf.resize(int(leaf.width*.35), int(leaf.height*.35)); 
 
 imageMode(CENTER);
 textAlign(RIGHT); 

}

void draw(){
 background(255);  
 yoffset += dy; 


 
 //image(leaf, 0, 0); 

 
 for(int i = 0; i < icons.length; i++){
   float scale = map(i, 0, icons.length, -icons[i].height, height*1.25+icons[i].height); 
   pushMatrix(); 
   translate(icons[i].width , (yoffset + scale)%(height*1.25 + icons[i].height*2)-icons[i].height); 
   rotate(angles[i]); 
   image(icons[i], 0, 0); 
   rotate(-angles[i]); 
   
   //image(icons[i], icons[i].width/3, (yoffset + scale)%(height*1.25 + icons[i].height*2)-icons[i].height);
   popMatrix(); 
 }


 textSize(textSize); 
 textFont(font, textSize); 
 
 pushMatrix();
 rotate(-PI/2);
 translate(0, width); 
 fill(150, 246, 242);
 text("revolv.io", 0, 0); 
 popMatrix();
 
 
 textSize(40);
 fill(0);
 text("change the world not your day", width, 600); 
  
 /*
 for(int i = 0; i < rewords.length; i++){
   float scale = map(i, 0, rewords.length, -textSize*2, height*1.25+textSize);
   fill(150, 246, 242);
   if(rewords[i] == "re.volv") fill(39, 94, 89);
   text(rewords[i], 5, (yoffset+scale)%(height*1.25 + textSize*3) - textSize*2); 
 }
 */
}