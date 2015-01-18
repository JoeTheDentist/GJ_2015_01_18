
Model gModel = new Model();
int playerSize = 36;

class Model {
  
  public void init() {
    player1.init("plop", 75, yHUD + 75);
    player2.init("plop", xWindow - playerSize - 75, yWindow - playerSize - 75);
  }
  
  void draw_me() { 
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
  
  public void move(int ix, int iy) {
    x += ix;
    y += iy;
    if (x < -playerSize)
      x = xWindow - playerSize;
    if (x > xWindow)
      x = - playerSize;
    if (y < yHUD - playerSize)
      y = yWindow - playerSize;
    if (y > yWindow)
      y = yHUD - playerSize;
  }
  
  public void init(String imageName, int ix, int iy) {
    image = imageName;
    x = ix;
    y = iy;
  }
  
  void draw_me() { 
    gGraphics.drawPict(image, x, y); 
  }
  
}
