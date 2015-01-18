
Model gModel = new Model();
int playerSize = 36;
int gridSize = 50;

class Model {
  
  public void init() {
    player1.init("plop", 75, yHUD + 75);
    player2.init("plop", xWindow - playerSize - 75, yWindow - playerSize - 75);
  }
  
  void draw() { 
    player1.draw();
    player2.draw();  
  }
  
  void update(int dt) {
    player1.update(dt);
    player2.update(dt);
  }
  
  public Player player1 = new Player(1);
  public Player player2 = new Player(2);
}

class Player {
  private static final int speed = 500;
  int x = 0;
  int y = 0;
  String image = "";
  int id;
  BoundingBox box = new BoundingBox(0, 0, playerSize, playerSize);
  
  Player(int id) { this.id = id; }
  
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
  
  public void update(int dt) {
    int coef = -speed*dt/1000;
    int xSpeed = 0;
    int ySpeed = 0;
    if (id == 1) {
      xSpeed = (gInputs.checkKey('d')?1:0)*coef - (gInputs.checkKey('a')?1:0)*coef;
      ySpeed = (gInputs.checkKey('s')?1:0)*coef - (gInputs.checkKey('w')?1:0)*coef;
    } else if (id == 2) {
      xSpeed = (gInputs.checkKey('l')?1:0)*coef - (gInputs.checkKey('j')?1:0)*coef;
      ySpeed = (gInputs.checkKey('k')?1:0)*coef - (gInputs.checkKey('i')?1:0)*coef;
    }
    move(xSpeed, ySpeed);
  }
  
  void draw() { 
    gGraphics.drawPict(image, x, y); 
  }
}
