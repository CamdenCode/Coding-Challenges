void setup() {
  size(600, 600);
}

int r = 100;
float angle1 = -HALF_PI;
float angle2 = -HALF_PI;
float angle3 = -HALF_PI;

ArrayList<float[]> path = new ArrayList<float[]>();

void draw() {
  background(51);
  noFill();
  translate(width/2, height/2);
  stroke(255);
  ellipse(0, 0, 2 * r, 2 * r);
  float x1 = 1.5 * r * cos(angle1);
  float y1 = 1.5 * r * sin(angle1);
  ellipse(x1, y1, r, r);
  //translate(1.5 * r * cos(angle1), 1.5 * r * sin(angle1));
  //ellipse(0.75 * r * cos(angle2 * 4), 0.75 * r * sin(angle2 * 4), r/2, r/2);
  //translate(0.75 * r * cos(angle2 * 4), 0.75 * r * sin(angle2 * 4));
  //ellipse(0.375 * r * cos(angle3 * 8), 0.375 * r * sin(angle3 * 8), r/4, r/4);
  
  float x2 = x1 + (0.75 * r * cos(-angle1*4 - HALF_PI));
  float y2 = y1 + (0.75 * r * sin(-angle1*4 - HALF_PI));
  ellipse(x2, y2, r/2, r/2);
  
  float x3 = x2 + (0.375 * r * cos(angle1 * 16 - HALF_PI));
  float y3 = y2 + (0.375 * r * sin(angle1 * 16 - HALF_PI));
  ellipse(x3, y3, r/4, r/4);
  
  float[] point = new float[2];
  point[0] = x3;
  point[1] = y3;
  path.add(point);
  
  for(int i = 0; i < path.size()-1; i++){
     point(path.get(i)[0], path.get(i)[1]); 
     line(path.get(i)[0], path.get(i)[1], path.get(i+1)[0], path.get(i + 1)[1]);
  }
  
  angle1 -= HALF_PI / 128;

}