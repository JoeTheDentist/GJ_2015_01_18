import java.util.List;

Model gModel = new Model();
int playerSize = 50;
int gridSize = 50;

class Model {
  
  final Integer EMPTY = 0;
  final Integer WALL = 1;
  int nbxgrid = 0;
  int nbygrid = 0;
  char[] keys1 = {'w', 's', 'a', 'd'};
  char[] keys2 = {'i', 'k', 'j', 'l'};
  Rule rule;
  
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
    reset();
  }
  
  public void reset() {
    player1.init("chk_red", keys1, 75, yHUD + 75);
    player2.init("chk_blu", keys2, xWindow - playerSize - 75, yWindow - playerSize - 75);
    rule = new Rule(null, Direction.UP);
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

class Rule {
  private int forbidenKey;
  private String[] images;
  
  Rule(String images[], int forbidenKey) {
    this.images = images;
    this.forbidenKey = forbidenKey;
  }
  
  int getForbidenKey(int id) {
    if (id == 1) { return forbidenKey; }
    if (forbidenKey % 2 == 0) { return forbidenKey+1; }
    else { return forbidenKey-1; }
  }
  
  void draw() {}
}

class Direction {
  public static final int UP = 0;
  public static final int DOWN = 1;
  public static final int LEFT = 2;
  public static final int RIGHT = 3;
}

class Player {
  private static final int speed = 500;
  private char[] keys;
  
  int x = 0;
  int y = 0;
  String image = "";
  int score = 0;
  int id;
  BoundingBox box = new BoundingBox(0, 0, 0, 0, 5);
  
  Player(int id) { this.id = id; }
  
  public void init(String imageName, char[] keys, int ix, int iy) {
    image = imageName;
    x = ix;
    y = iy;
    box._x = x;
    box._y = y;
    box._border = 5;
    box._x = x + box._border;
    box._y = y + box._border;
    box._width = playerSize;
    box._height = playerSize;
    this.keys = keys;
  }
  
  public void move(int ix, int iy) {
    int teleportMargin = 2;
    int xtmp = box._x + ix;
    int ytmp = box._y + iy;
    if (xtmp < -(playerSize - teleportMargin))
      xtmp = xWindow - playerSize + teleportMargin;
    if (xtmp > xWindow - teleportMargin)
      xtmp = - playerSize + teleportMargin;
    if (ytmp < yHUD - (playerSize - teleportMargin))
      ytmp = yWindow - playerSize + teleportMargin;
    if (ytmp > yWindow - teleportMargin)
      ytmp = yHUD - playerSize + teleportMargin;
      
    box._x = xtmp;
    if (!hasCollision() && !Collide(gModel.player1.box,gModel.player2.box)) {
      x = xtmp - box._border;
    }
    box._x = x + box._border;
    
    box._y = ytmp;
    if (!hasCollision() && !Collide(gModel.player1.box,gModel.player2.box)) {
      y = ytmp - box._border;
    } 
    box._y = y + box._border;
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

  public void update(int dt) {
    if (gInputs.checkKey(keys[gModel.rule.getForbidenKey(id)])) { gameover("Player "+id+" lose"); }
    int coef = -speed*dt/1000;
    int xSpeed = (gInputs.checkKey(keys[Direction.RIGHT])?1:0)*coef - (gInputs.checkKey(keys[Direction.LEFT])?1:0)*coef;
    int ySpeed = (gInputs.checkKey(keys[Direction.DOWN])?1:0)*coef - (gInputs.checkKey(keys[Direction.UP])?1:0)*coef;
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
