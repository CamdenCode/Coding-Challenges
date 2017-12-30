float sigma = 10.0;
float beta = 8.0/3.0;
float rho = 28.0;

float x = 1;
float y = 1;
float z = 1;

float scl = 4;

void setup() {
  size(600, 600, P3D);
}

ArrayList<float[]> path = new ArrayList<float[]>();
float angle = 0.0;

float hue = 0;

void draw() {
  
  angle+=0.01;
  
  translate(width/2, height/2);
  rotateY(angle);
  background(255);
  noFill();
  stroke(100, 100, 150);

  
  float futureX = x + dxdt(x,y)/75;
  float futureY = y + dydt(x,y,z)/75;
  float futureZ = z + dzdt(x,y,z)/75;
  x = futureX;
  y = futureY;
  z = futureZ;
  point(x * scl,y * scl,z * scl);
  
  float[] newPath = {x * scl, y * scl, z * scl, ++hue};
    
  colorMode(HSB);
  
  if(hue > 255){
    hue = 0;
  }
  
  path.add(newPath);
  beginShape();
  for(float[] i : path){
    stroke(i[3], 255, 255);
    vertex(i[0], i[1], i[2]);
  }
  endShape();
  
}

float dxdt(float x, float y){
  return sigma * (y - x);
}

float dydt(float x, float y, float z){
  return x * (rho - z) - y;  
}

float dzdt(float x, float y, float z){
  return (x * y) - (beta * z);
}