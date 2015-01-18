
Model gModel = new Model();

class Model {
  
  public void init() {
    player1.init("plop", 0, 0);
    player2.init("plop", 200, 200);
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
