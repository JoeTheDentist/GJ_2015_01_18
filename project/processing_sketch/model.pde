
Model gModel = new Model();
int playerSize = 36;
int gridSize = 50;

class Model {
  
  public void init() {
    player1.init("plop", 75, yHUD + 75);
    player2.init("plop", xWindow - playerSize - 75, yWindow - playerSize - 75);
  }
  
  void draw_me() { 
    
    if (Debug) {
      for (int y = yHUD; y < yWindow; y+= gridSize) {
        line(0, y, xWindow, y);  
      }
      for (int x = 0; x < xWindow; x+= gridSize) {
        line(x, 0, x, xWindow);  
      }
    }
    
    player1.draw_me();
    player2.draw_me();  
  }
  
  public Player player1 = new Player();
  public Player player2 = new Player();
}

class Player {
  
  int x = 0;
  int y = 0;
  String image = "";
  BoundingBox box = new BoundingBox(0, 0, playerSize, playerSize);
  
  public void move(int ix, int iy) {
    int xtmp = x + ix;
    int ytmp = y + iy;
    if (xtmp < -playerSize)
      xtmp = xWindow - playerSize;
    if (xtmp > xWindow)
      xtmp = - playerSize;
    if (ytmp < yHUD - playerSize)
      ytmp = yWindow - playerSize;
    if (ytmp > yWindow)
      ytmp = yHUD - playerSize;
      
    x = xtmp;
    y = ytmp;
      
    box._x = x;
    box._y = y;
  }
  
  public void init(String imageName, int ix, int iy) {
    image = imageName;
    x = ix;
    y = iy;
    box._x = x;
    box._y = y;
  }
  
  void draw_me() { 
    gGraphics.drawPict(image, x, y); 
  }
  
}
