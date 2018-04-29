String test;

class Matrix{
    int r, c;
    float w, h;
    float cellWidth, cellHeight;
    float x, y;
    Matrix(){}
    
    Matrix(int r, int c, float w, float h){
        this.r = r;
        this.c = c;
        this.w = w;
        this.h = h;
        this.cellWidth = this.w/this.r;
        this.cellHeight = this.h/this.c;
        println(cellWidth, cellHeight, r, c);
        this.x = 20;
        this.y = 20;
    }
    
    void draw(){
      test = "";
      
      stroke(0);
      noFill();
      rect(x, y, w, h);
      
      translate(this.x, this.y);
      for(int i =0; i<r; i++){
          for(int j = 0; j<c; j++){
              rect(i*cellWidth, j*cellHeight, cellWidth, cellHeight); 
          }
      }
      translate(-this.x, -this.y);
      
      
     int amount_red = 255;
     int opacity = 255;
     
     //Finger Tips
     for(PVector p : fingerTips){
         PVector loc = XYtoMatrix(p); 
         PVector rectLoc = XYtoRC(loc);
         fill(amount_red, 0, 0, opacity);
         rect(this.x + rectLoc.x*cellWidth, this.y + rectLoc.y*cellHeight, cellWidth, cellHeight);
         fill(255, 0, 255);
         ellipse(loc.x, loc.y, 5, 5);
         test += rectLoc.x + "," + rectLoc.y + "," + amount_red + "/";
      }
      
      amount_red -= 30;
      
      //Distal Bones
      for(PVector p : distalBones){
         PVector loc = XYtoMatrix(p); 
         PVector rectLoc = XYtoRC(loc);
         fill(amount_red, 0, 0, opacity);
         rect(this.x + rectLoc.x*cellWidth, this.y + rectLoc.y*cellHeight, cellWidth, cellHeight);
         fill(255, 0, 255);
         ellipse(loc.x, loc.y, 5, 5);
         test += rectLoc.x + "," + rectLoc.y + "," + amount_red + "/";
      }
      
      amount_red -= 30;
      
      //Inter Bones
      for(PVector p : interBones){
         PVector loc = XYtoMatrix(p); 
         PVector rectLoc = XYtoRC(loc);
         fill(amount_red, 0, 0, opacity);
         rect(this.x + rectLoc.x*cellWidth, this.y + rectLoc.y*cellHeight, cellWidth, cellHeight);
         fill(255, 0, 255);
         ellipse(loc.x, loc.y, 5, 5);
         test += rectLoc.x + "," + rectLoc.y + "," + amount_red + "/";
      }

      amount_red -= 30;

      //Prox Bones
      for(PVector p : proxBones){
         PVector loc = XYtoMatrix(p); 
         PVector rectLoc = XYtoRC(loc);
         fill(amount_red, 0, 0, opacity);
         rect(this.x + rectLoc.x*cellWidth, this.y + rectLoc.y*cellHeight, cellWidth, cellHeight);
         fill(255, 0, 255);
         ellipse(loc.x, loc.y, 5, 5);
         test += rectLoc.x + "," + rectLoc.y + "," + amount_red + "/";
      }

      amount_red -= 30;

      //Meta Bones
      for(PVector p : metaBones){
         PVector loc = XYtoMatrix(p); 
         PVector rectLoc = XYtoRC(loc);
         fill(amount_red, 0, 0, opacity);
         rect(this.x + rectLoc.x*cellWidth, this.y + rectLoc.y*cellHeight, cellWidth, cellHeight);
         fill(255, 0, 255);
         ellipse(loc.x, loc.y, 5, 5);
         test += rectLoc.x + "," + rectLoc.y + "," + amount_red + "/";
      }
           
      amount_red -= 30;
           
      //Hand Centers Bones
      for(PVector p : handPos){
         PVector loc = XYtoMatrix(p); 
         PVector rectLoc = XYtoRC(loc);
         fill(amount_red, 0, 0, opacity);
         rect(this.x + rectLoc.x*cellWidth, this.y + rectLoc.y*cellHeight, cellWidth, cellHeight);
         fill(255, 0, 255);
         ellipse(loc.x, loc.y, 5, 5);
         test += rectLoc.x + "," + rectLoc.y + "," + amount_red + "/";
      }
                   
      
      //if(frameCount % 2 == 0){
      myPort.write(1);
      //}
      
    }
    
    PVector XYtoMatrix(PVector loc){
        float newX = map(loc.x, 0, width, x, w);
        float newY = map(loc.y, 0, height, y, h);
        return new PVector(newX, newY);
    }
    
    PVector XYtoRC(PVector loc){
        int x = floor(loc.x/cellWidth) - 1;
        int y = floor(loc.y/cellHeight) - 1;
        return new PVector(int(x), int(y));
    }
    
}


void keyPressed(){
  println(test);
}
