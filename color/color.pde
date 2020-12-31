/**
*Morgan Gomez
* 902738866
* LMC 1700
* 10/17/18
*/

//variables for gathering images
Table table;
ArrayList<circles> images = new ArrayList<circles>();

//variables for small circles
int circleSize = 10;

//large circle data
int radius; 

//variable for loading screen
boolean loaded;

void setup() {
  size(800,800);
  background(#E8E2D7);
  radius = width/2 + 300;
  fill(0);
  smooth();
  loaded = false;   
  thread("loadData");
}

void draw() {
  background(#E8E2D7);
  noFill();
  strokeWeight(0.3);
  stroke(0);
  textSize(9);
  if (!loaded){
    text("Loading...", 40, 35);
    text("Feel free to hover over circles while all images load!", 40, 50);
  }
 
  text("HOW TO READ:", 450, 25);
  text("Days & hours are displayed like a clock face, with noon halfway in between days", 450, 35);
  text("Minutes & seconds are represented as distance from center,", 450, 45);
  text("with 00m:00s at the center.", 465, 55);
  
  for (int i = 0; i < 6; i++){
    ellipse(height/2 , width/2 , radius - (i * 120), radius - (i *120));
  }
  for (int i = 1; i < 7; i++){
    if (i * 10 == 60){
      text(i * 10, height/2, height/2 - i * 55  - 10);
    } else {
     text(i * 10, height/2, height/2 - i * 55);
    }
  }


  //draw lines
  float pointAngle = 40; //angle between points
  int tempRadius = 350;
  for(float angle = 0; angle < 360; angle = angle+pointAngle) { //move round the circle to each point
    float x = cos(radians(angle - 90)) * tempRadius; //convert angle to radians for x and y coordinates
    float y = sin(radians(angle - 90)) * tempRadius;
    
    line(400, 400, x + 400, y + 400);
    strokeWeight(0.5);
  }

    drawCircles();
    update();
    
    //setup Days
    fill(0);
    for (int i = 0; i < 9; i++){
      coordinates c = new coordinates(17 + i, 0, 62, 60);
      if (17 + i == 21){
        text(17 + i + "st", c.getR(), c.getTheta());
      } else if (17 + i == 22 ){
         text(17 + i + "nd", c.getR(), c.getTheta());
      }  else if (17 + i == 23 ){
         text(17 + i + "rd", c.getR(), c.getTheta());
      }
      else {
        text(17 + i + "th", c.getR(), c.getTheta());
      }
    }
 
}

void update(){
  for (int i = 0; i < images.size(); i++){
    if (overCircle(images.get(i).getX(), images.get(i).getY(), circleSize)){
      images.get(i).display();
    } 
  }
}

boolean overCircle(float x, float y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

void loadData(){
  //Loads cvs files
  table = loadTable("data.csv", "header");
  println(table.getRowCount() + " total rows in table");
  for (TableRow row : table.rows()) {
    String name = row.getString("name");
    String date = row.getString("date (yyyy_mm_dd_hh_mm_ss)");
    String tag1 = row.getString("tag 1");
    String tag2 = row.getString("tag 2");
    String tag3 = row.getString("tag 3");
    circles c;
    if (name.contains(".jpg")){
       c = new circles(loadImage(name), name, date, tag1, tag2, tag3);
    } else {
       c = new circles(loadImage(name + ".jpg"), name, date, tag1, tag2, tag3);
    }
    images.add(c);
  }
  loaded = true;
}

void drawCircles(){
  for (int i = 0; i < images.size(); i++){
    fill(images.get(i).getColor());
    noStroke();
    ellipse(images.get(i).getX(), images.get(i).getY(), circleSize, circleSize);
  }  
}


//for testing
int numMissing(){
  int missing = 0;
  for (int i = 0; i < images.size(); i++){
    if (images.get(i).getX() == 0){
      missing++;
      System.out.println(images.get(i).getName());
      System.out.println(images.get(i).getName());;
      
    }
  }
  return missing;
}
