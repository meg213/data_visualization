/**
*this class generates x and y coordinates for each circle
*/
class coordinates{
  float r;
  float theta;
  
   coordinates(int day, int hour, int min, int sec){
     int tempRadius = makeRadius(min, sec);
     float angle = 40 * (day - 17) + (1.6 * hour); //1.6 bc 40/24 = 1.6
     r = cos(radians(angle - 90)) * tempRadius; //convert angle to radians for x and y coordinates
     theta = sin(radians(angle - 90)) * tempRadius;
   } 
   
   int makeRadius(int min, int sec){
     int radius = 0;
     radius += (min * 5);
     radius += sec;
     return radius;
   }
   
    float getR(){
     return r + 400;
   }
   
   float getTheta(){
     return theta + 400;
   }
}
