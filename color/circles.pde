

class circles{
PImage image;
color mainColor;
String name;
String tag1;
String tag2;
String tag3;
String date;
float yPos;
float xPos;
int day;
int hour;
int minute;
int second;
coordinates c;
PFont f;
boolean isMissing;

circles(PImage img, String name, String date, String tag1, String tag2, String tag3){
  img.resize(0,120);
  image = img;
  mainColor = extractDominantColor(image);
  this.name = name;
  this.date = date;
  this.tag1 = tag1;
  this.tag2 = tag2;
  this.tag3 = tag3;
  isMissing = getTime(date);
  setCoordinates(day, hour, minute, second);
  }
  
color extractDominantColor(PImage img){
  //create a hashmap - the key is the color, the value associated is the number of pixels peru color
  HashMap<Integer,Integer> colorCounter = new HashMap<Integer,Integer>();
  img.loadPixels();
  int numPixels = img.pixels.length;
  
  
  for (int i=0; i<numPixels; i++){
    int colorKey = img.pixels[i];
    //if the color has already been added to the hashmap, increment the count
    if(colorCounter.containsKey(colorKey)){
      colorCounter.put(colorKey,colorCounter.get(colorKey)+1);
    }else{//otherwise count it as 1
      colorCounter.put(colorKey,1);
    }
  }
  int max = 0;//what's the highest density of pixels per one colour
  int dominantColor = 0;//which colour is it

  //for each key (color) in the keyset  
  for(int colorKey : colorCounter.keySet()){
    //get the pixel count per colour
    int count = colorCounter.get(colorKey);
    //if this one is the highest, updated the max value and keep track of the colour
    if(count > max){
      max = count;
      dominantColor = colorKey; 
    }
  }
  //return the colour with most pixels associated
  return dominantColor;
}

PImage getImage(){
  return image;
}

color getColor(){
  return mainColor;
}

void setX(float x){
  xPos = x;
}
void setY(float y){
  yPos = y;
}

float getX(){
  return xPos;
}
float getY(){
  return yPos;
}
String getName(){
  return name;
}

boolean isMissing(){
  return isMissing;
}
void display(){
  fill(mainColor);
  if (xPos > 640 && yPos < 550){ //needs flip on y axis 
    rect(xPos - 140, yPos, 140, 200);
    fill(255);
    rect(xPos + 8 - 140, yPos + 8, 123, 123);
    image(image, xPos + 10 - 140, yPos + 10, 120, 120);
    makeText(name, xPos + 8 - 140, yPos + 145, "AvenirNext-Bold",11);
    makeText(date, xPos + 8 -140, yPos + 160, "AvenirNext-Light", 9);
    makeText(tag1, xPos + 8 - 140, yPos + 170, "AvenirNext-Light", 9);
    makeText(tag2, xPos + 8 - 140, yPos + 180, "AvenirNext-Light", 9);
    makeText(tag3, xPos + 8 - 140, yPos + 190, "AvenirNext-Light", 9);
 
  } else if (xPos < 640 && yPos > 550) { //needs flip on x axis
    rect(xPos, yPos - 200, 140, 200);
    fill(255);
    rect(xPos + 8, yPos - 200 + 8, 123, 123);
    image(image, xPos + 10, yPos + 10 - 200, 120, 120);
    makeText(name, xPos + 8, yPos + 145 - 200, "AvenirNext-Bold", 11);
    makeText(date, xPos + 8, yPos + 160 - 200, "AvenirNext-Ligh", 9);
    makeText(tag1, xPos + 8, yPos + 170 - 200, "AvenirNext-Light", 9);
    makeText(tag2, xPos + 8, yPos + 180 - 200, "AvenirNext-Light", 9);
    makeText(tag3, xPos + 8, yPos + 190 - 200, "AvenirNext-Light", 9);

  }else if (xPos > 640 && yPos > 550){ //needs total flip
    rect(xPos - 140, yPos - 200, 140, 200);
    fill(255);
    rect(xPos + 8 - 140, yPos - 200 + 8, 123, 123);
    image(image, xPos + 10 - 140, yPos + 10 - 200, 120, 120);
    makeText(name, xPos + 8 - 140, yPos + 145 - 200, "AvenirNext-Bold", 11);
    makeText(date, xPos + 8 - 140, yPos + 160 - 200, "AvenirNext-Light", 9);
    makeText(tag1, xPos + 8 - 140, yPos + 170 - 200, "AvenirNext-Light", 9);
    makeText(tag2, xPos + 8 - 140, yPos + 180 - 200, "AvenirNext-Light", 9);
    makeText(tag3, xPos + 8 - 140, yPos + 190 - 200, "AvenirNext-Light", 9);
    
  } else {
    rect(xPos, yPos, 140, 200);
    fill(255);
    rect(xPos + 8, yPos + 8, 123, 123);
    image(image, xPos + 10, yPos + 10, 120, 120);
    makeText(name, xPos + 8, yPos + 145, "AvenirNext-Bold", 11);
    makeText(date, xPos + 8, yPos + 160, "AvenirNext-Light", 9);
    makeText(tag1, xPos + 8, yPos + 170, "AvenirNext-Light", 9);
    makeText(tag2, xPos + 8, yPos + 180, "AvenirNext-Light", 9);
    makeText(tag3, xPos + 8, yPos + 190, "AvenirNext-Light", 9);
  }
  
}//display

boolean getTime(String time){
 
    if (time.length() != 19){
      if (time.length() == 16){ //didn't inclde seconds
         day = Integer.parseInt(time.substring(8,10));
         hour = Integer.parseInt(time.substring(11,13));
         minute = Integer.parseInt(time.substring(14,16));
         second = (int)random(60);
         return false;
      }else if (time.length() == 13){ //didn't include minutes, sec
         day = Integer.parseInt(time.substring(8,10));
         hour = Integer.parseInt(time.substring(11,13));
         minute = (int)random(60);
         second = (int)random(60);
         return false;
      } else if (time.length() == 10){ //didn't include hour, min, sec
         day = Integer.parseInt(time.substring(8,10));
         hour = (int)random(24);
         minute = (int)random(15,60);
         second = (int)random(60);
         return false;
      } else if (time.contains("Sep")){ //honestly fuck these people why did they do it like this
          day = Integer.parseInt(time.substring(0,2));
          hour = (int)random(24);
          minute = (int)random(10, 60);
          second = (int)random(60);
          return false;
      } else if (time.contains("N/A")){
         day = (int) random(17,25);
         hour = (int)random(24);
         minute = (int)random(30,60);
         second = (int)random(60); 
         return false;
      } else {
        System.out.println(time);
        return true;
      }
    } else {
     day = Integer.parseInt(time.substring(8,10));
     hour = Integer.parseInt(time.substring(11,13));
     minute = Integer.parseInt(time.substring(14,16));
     second = Integer.parseInt(time.substring(17,19));
     return false;
  }
}


int getDay(){
  return day;
}
int getHour(){
  return hour;
}
int getMinute(){
  return minute;
}
int getSecond(){
  return second;
}
void setCoordinates(int d, int h, int m, int s){
  c = new coordinates(d, h, m, s);
  xPos = c.getR();
  yPos = c.getTheta();
}

void makeText(String text, float x, float y, String font, int size){
  if (getColor() == -1){
      fill(0); //black
  } else {
      fill(255); //white
  }
      
  f = createFont(font, size);
  textFont(f);
  text(text,  x, y);  
}
}//class circles
