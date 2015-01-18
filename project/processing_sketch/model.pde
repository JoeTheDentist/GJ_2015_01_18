import java.util.List;

Model gModel = new Model();
int playerSize = 60;
int gridSize = 50;

class Model {
  
  final Integer EMPTY = 0;
  final Integer WALL = 1;
  int nbxgrid = 0;
  int nbygrid = 0;
  
  public void init() {   
    nbxgrid = xWindow / gridSize;
    nbygrid = (yWindow - yHUD) / gridSize + 1;
    println("grid: " + nbxgrid + "*" + nbygrid);
    for (int x = 0; x < nbxgrid; ++x) {
      grid.add(new ArrayList<Integer>());
      for (int y = 0; y < nbygrid; ++y) { 
        if ( ((x == 0) && (y != 5) && (y != 6)) ||
             ((x == nbxgrid - 1) && (y != 5) && (y!= 6)) ||
             ((y == 0) && (x != 7) && (x!= 8)) ||
             ((y == nbygrid - 1) && (x != 7) && (x!= 8)) )
           grid.get(x).add(WALL);
         else
           grid.get(x).add(EMPTY);
      }
    }
    player1.init("chk_red", 75, yHUD + 75);
    player2.init("chk_blu", xWindow - playerSize - 75, yWindow - playerSize - 75);
  }
  
  void draw() { 
    player1.draw();
    player2.draw();  
    if (Debug) {
      for (int y = yHUD; y < yWindow; y+= gridSize) {
        stroke(1);
        line(0, y, xWindow, y);  
      }
      for (int x = 0; x < xWindow; x+= gridSize) {
        stroke(1);
        line(x, 0, x, xWindow);  
      }
      for (BoundingBox box : gBoxes) {
        box.draw();
      }
      for (int x = 0; x < grid.size(); ++x) {
        for (int y = 0; y < grid.get(0).size(); ++y) {
          if (grid.get(x).get(y) != EMPTY) {
            noStroke();
            fill(256, 0, 0, 50);
            rect(x*gridSize, yHUD + y*gridSize, gridSize, gridSize);
          }
        } 
      }
    }
  }
  
  void update(int dt) {
    player1.update(dt);
    player2.update(dt);
  }
  
  public Player player1 = new Player(1);
  public Player player2 = new Player(2);
  public ArrayList<ArrayList<Integer>> grid = new ArrayList<ArrayList<Integer>>();

}

class Player {
  private static final int speed = 500;
  int x = 0;
  int y = 0;
  String image = "";
  int score = 0;
  int id;
  BoundingBox box = new BoundingBox(0, 0, 0, 0);
  
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
      
    box._x = xtmp;
    if (!hasCollision()) {
      x = xtmp;
    }
    box._x = x;
    
    box._y = ytmp;
    if (!hasCollision()) {
      y = ytmp;
    } 
    box._y = y;
  }
  
  public Boolean hasCollision() {
    int boxy = (box._y - yHUD) / gridSize;
    int boxx = box._x / gridSize;
    int boxxx = (box._x + box._width) / gridSize;
    int boxyy = (box._y - yHUD + box._height) / gridSize;
    if (boxx >= 0 && boxy >=0 && boxx < gModel.nbxgrid && boxy < gModel.nbygrid && (gModel.grid.get(boxx).get(boxy) != gModel.EMPTY)) return true;
    if (boxxx >= 0 && boxy >=0 && boxxx < gModel.nbxgrid && boxy < gModel.nbygrid &&(gModel.grid.get(boxxx).get(boxy) != gModel.EMPTY)) return true;
    if (boxxx >= 0 && boxyy >=0 && boxxx < gModel.nbxgrid && boxyy < gModel.nbygrid &&(gModel.grid.get(boxxx).get(boxyy) != gModel.EMPTY)) return true;
    if (boxx >= 0 && boxyy >=0 && boxx < gModel.nbxgrid && boxyy < gModel.nbygrid &&(gModel.grid.get(boxx).get(boxyy) != gModel.EMPTY)) return true;
  
    return false;  
  }
  
  public void init(String imageName, int ix, int iy) {
    image = imageName;
    x = ix;
    y = iy;
    box._x = x;
    box._y = y;
    box._width = playerSize;
    box._height = playerSize;
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
  
  public void changeScore(int iScore)
  {
    score += iScore;
  }
  
  void draw() { 
    gGraphics.drawPict(image, x, y); 
  }
}
