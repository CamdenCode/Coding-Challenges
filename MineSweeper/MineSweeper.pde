int n = 25;
float p = 0.15;
int grid[][];
boolean debug = false;
int bombs = 0;
boolean flag = false;

void setup() {
  size(1000, 1000);
  grid = new int[n][n];
  generateBoard();
}
int hoveredX;
int hoveredY;

boolean notClicked = true;

boolean lost = false;

void draw() {
  stroke(0);
  float rectWidth = width / n;
  float rectHeight = height / n;
  float bombWidth = rectWidth / 2;
  textSize(rectWidth / 2);
  hoveredX = floor(mouseX / rectWidth);
  hoveredY = floor(mouseY / rectWidth);
  colorMode(RGB);
  boolean won = true;
  color fillColor = 255;
  for (int y = 0; y < n; y++) {
    for (int x = 0; x < n; x++) {
      if (grid[x][y] == 10 || grid[x][y] == 20){
         won = false; 
      }
      if (hoveredX == x && hoveredY == y) {
        if (!flag)
          fillColor = color(190 - noise(x, y) * 30, 190 - noise(x, y) * 30, 255);
        else
          fillColor = color(255, 190 - noise(x, y) * 30, 190 - noise(x, y) * 30);
      } else {
        fillColor = color(210 - noise(x, y) * 30, 210 - noise(x, y) * 30, 255);
      }
      fill(fillColor);
      rect(x * rectWidth, y * rectHeight, rectWidth, rectHeight);
    }
  } 
  
  if (won){
    fill(255);
    textSize(20);
    text("You win!", width/2 - 10, height/2 -10);
  }
  
  textSize(rectWidth/2);
  
  fill(fillColor);
  
  for (int y = 0; y < n; y++) {
    for (int x = 0; x < n; x++) {
      if ((grid[x][y] == 10 && debug) || grid[x][y] == 20 || grid[x][y] == 10 && lost) {
        fill (0);
        rect(x * rectWidth + rectWidth / 4, y * rectHeight + rectHeight / 4, 
          bombWidth, bombWidth);
      } else if ((grid[x][y] > 10 && grid[x][y] < 50) || debug || lost) {
        fill(230, 230, 255);
        rect(x * rectWidth, y * rectHeight, rectWidth, rectHeight);
        colorMode(HSB);
        fill(grid[x][y] % 10 * (255 / 10), 255, 255);
        text(grid[x][y] % 10, (x + 0.25) * rectWidth, (y + 0.75) * rectHeight);
      } 
      colorMode(RGB);
      if (grid[x][y] <= -1 && !debug) {
        if (grid[x][y] == -1) {
          fill(240, 240, 255);
        } else {
          fill(255, 255, 255);
        }
        rect(x * rectWidth, y * rectHeight, rectWidth, rectHeight);
      }
      if (grid[x][y] > 50){
        fill(255, 150, 150);
         rect(x * rectWidth, y * rectHeight, rectWidth, rectHeight);
      }
    }
  }
}

void keyTyped() {
  if (key == 'd') {
    debug = !debug;
  }
  if (key == 'r') {
    lost = false;
    generateBoard();
    notClicked = true;
    flag = false;
  }
  if (key == 'f') {
     flag = !flag; 
  }
}

void mouseClicked() {
  int x = hoveredX;
  int y = hoveredY;

  if (flag){
    if (grid[x][y] > 50){
       grid[x][y] -= 50;
    }else if (grid[x][y] > 0){
       grid[x][y] += 50; 
    }
    return;
  }
  
  
  if (notClicked) {
    notClicked = false;
    while (grid[x][y] != 0) {
      generateBoard();
    }
  }

  if (grid[x][y] == 10)
  {
    lost = true;
  }

  if (grid[x][y] == 0) {
    showAdjacent(x, y);
  } else if (grid[x][y] < 10 && grid[x][y] > 0) {
    grid[x][y] += 10;
  }
}

void showAdjacent(int x, int y) {

  int adjacent = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0) {
        continue;
      }
      if (getSquare(x + i, y + j) <= 0 || getSquare(x + i, y + j) == 11) {
        adjacent++;
      }
    }
  }
  if (adjacent != 8) {
    grid[x][y] = -1;
  } else {
    grid[x][y] = -2;
  }
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (i == 0 && j == 0) {
        continue;
      }
      if (getSquare(x + i, y + j) == 0) {
        showAdjacent(x + i, y + j);
      } else if (getSquare(x+i, y+j) != 11 && getSquare(x+i, y+j) != 10 && getSquare(x+i, y+j) >0) {
        grid[x+i][y+j] += 10;
      }
    }
  }
}

void generateBoard() {
  bombs = 0;
  //Random Bombs
  for (int y = 0; y < n; y++) {
    for (int x = 0; x < n; x++) {
      if (random(1) <= p) {
        grid[x][y] = 10;
        bombs++;
      } else {
        grid[x][y] = 0;
      }
    }
  }

  //Get rid of impossible to find bombs (completely surrounded)

  for (int y = 0; y < n; y++) {
    for (int x = 0; x < n; x++) {
      int adjacent = 0;
      int walls = 0;
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          if (i == 0 && j == 0) {
            continue;
          }
          if (getSquare(x + i, y + j) == 10) {
            adjacent++;
          } else if (getSquare(x + i, y + j) == 11) {
            walls++;
          }
        }
      }

      if (adjacent + walls == 8) {
        grid[x][y] = 0;
      }

      if (grid[x][y] == 0) {
        grid[x][y] = adjacent;
      }
    }
  }
}

int getSquare(int x, int y) {
  if (x <= -1 || y <= -1 || x >= n || y >= n) {
    return 11;
  }
  return grid[x][y];
}