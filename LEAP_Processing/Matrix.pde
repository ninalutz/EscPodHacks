
class Matrix{
    int r, c;
    float w, h;
    float cellWidth, cellHeight;
    float x, y;
    Matrix(){}
    
    String output;

    HashMap<Integer, Integer> test;
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
        this.test = new HashMap<Integer, Integer>();
    }
    
    void draw(){
      test = new HashMap<Integer, Integer>();
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
     int opacity = 100;
     
     translate(0, cellWidth);
     //Finger Tips
     for(PVector p : fingerTips){
         PVector loc = XYtoMatrix(p); 
         PVector rectLoc = XYtoRC(loc);
         fill(amount_red, 0, 0, opacity);
         rect(this.x + rectLoc.x*cellWidth, this.y + rectLoc.y*cellHeight, cellWidth, cellHeight);
         fill(255, 0, 255);
         ellipse(loc.x, loc.y, 5, 5);
         test.put(RCtoCell(rectLoc), amount_red);
     
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
         test.put(RCtoCell(rectLoc), amount_red);
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
         test.put(RCtoCell(rectLoc), amount_red);
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
         test.put(RCtoCell(rectLoc), amount_red);
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
         test.put(RCtoCell(rectLoc), amount_red);
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
         test.put(RCtoCell(rectLoc), amount_red);
      }
      
      
      //if(frameCount % 2 == 0){
      output = cleanTest(test);
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
    
    int RCtoCell(PVector RC){
        float thing = RC.x + (r*RC.y);
        return int(thing);
    }
    
    String cleanTest(HashMap<Integer, Integer> t){
      String out = "<";
     // println(t);
     for(Integer i : t.keySet()){
       out+= i + "," + t.get(i) + "/";
     }
     out+= ">";
      return out;
      
      }

    String randomOutput(){
      String out = "";
      for(int i =0; i<40; i++){
          out += int(random(400)) + "," + int(random(255)) + "/";
      }
      return out;
    }
}


void keyPressed(){
  println(matrix.output);
  myPort.write(matrix.output);
}