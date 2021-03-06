import java.util.List;

Model gModel = new Model();
int ruleDrawY = 56;
int playerSize = 40;
int gridSize = 50;

class Model {
  
  final Integer EMPTY = 0;
  final Integer WALL = 1;
  final Integer TRIGGER1 = 2;
  final Integer TRIGGER2 = 2;
  int nbxgrid = 0;
  int nbygrid = 0;
  char[] keys1 = {'w', 's', 'a', 'd'};
  char[] keys2 = {'i', 'k', 'j', 'l'};
  Rule rule;
  
  public void init() {   
    nbxgrid = xWindow / gridSize;
    nbygrid = (yWindow - yHUD) / gridSize + 1;
    grid = new int[nbxgrid][nbygrid];
    for (int x = 0; x < nbxgrid; ++x) {
      for (int y = 0; y < nbygrid; ++y) { 
        if ( ((x == 0) && (y != 5) && (y != 6)) ||
             ((x == nbxgrid - 1) && (y != 5) && (y!= 6)) ||
             ((y == 0) && (x != 7) && (x!= 8)) ||
             ((y == nbygrid - 1) && (x != 7) && (x!= 8)) )
           grid[x][y] = WALL;
         else
           grid[x][y] = EMPTY;
      }
    }
    reset();
  }
  
  public void reset() {
    player1.init("chk_red", keys1, 75, yHUD + 75);
    player2.init("chk_blu", keys2, xWindow - playerSize - 75, yWindow - playerSize - 75);
    rule = generateNewRule();
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
      for (int x = 0; x < grid.length; ++x) {
        for (int y = 0; y < grid[0].length; ++y) {
          if (grid[x][y] == WALL) {
            noStroke();
            fill(256, 0, 0, 50);
            rect(x*gridSize, yHUD + y*gridSize, gridSize, gridSize);
          }
          if (grid[x][y] == TRIGGER1 || grid[x][y] == TRIGGER2) {
            noStroke();
            fill(0, 255, 0, 50);
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
  public int[][] grid;

}

Rule generateNewRule() {
  return new Rule((int)random(0,4), (int)random(0,4) == 0);
}

int oppositeDirection(int direction) {
  if (direction % 2 == 0) { return direction+1; }
  else { return direction-1; }
}

class Rule {
  private int forbidenKey;
  private boolean lie;
  private String[] images;
  public TriggerArea trigger1 = new TriggerArea();
  public TriggerArea trigger2 = new TriggerArea();
  
  Rule(int forbidenKey, boolean lie) {
    this.forbidenKey = forbidenKey;
    this.lie = lie;
    String images[] = {gResources.getArrowName(1, forbidenKey), gResources.getArrowName(2, oppositeDirection(forbidenKey))};
    // Swap images randomly
    if ((int)random(3) == 0) {
      String temp = images[0];
      images[0] = images[1];
      images[1] = temp;
    }
    this.images = images;
    // reverse keys if lie mode
    if (this.lie) { this.forbidenKey = oppositeDirection(forbidenKey); }
    
    // create exit
    trigger1.onTrigger = new CallbackTrigger() {
      public void activate(int playerId) {
        roundover("Player "+playerId+" won");
        if (playerId == 1) 
         gModel.player1.changeScore(5);
        if (playerId == 2) 
         gModel.player2.changeScore(5);
      }  
    };
    gModel.grid[7][5] = gModel.TRIGGER1;
    gModel.grid[7][6] = gModel.TRIGGER1;
    gModel.grid[8][5] = gModel.TRIGGER1;
    gModel.grid[8][6] = gModel.TRIGGER1;
  }
  
  int getForbidenKey(int id) {
    if (id == 1) { return forbidenKey; }
    return oppositeDirection(forbidenKey);
  }
  
  void draw() {
    if (images == null || images.length == 0) { return; }
    if (images.length == 1) {
      gGraphics.drawPict("not_round", 350, ruleDrawY);
      gGraphics.drawPict(images[0], 350, ruleDrawY);
      gGraphics.drawPict("not_line", 350, ruleDrawY);
    }
    else {
      gGraphics.drawPict("not_round", 275, ruleDrawY);
      gGraphics.drawPict(images[0], 275, ruleDrawY);
      gGraphics.drawPict("not_line", 275, ruleDrawY);
      gGraphics.drawPict("not_round", 425, ruleDrawY);
      gGraphics.drawPict(images[1], 425, ruleDrawY);
      gGraphics.drawPict("not_line", 425, ruleDrawY);
    }
    gGraphics.drawPict("egg", 7*gridSize, 200+5*gridSize);
    if (this.lie) {
      gGraphics.drawPict("evil_chk", 350, 100);
    } else {
      gGraphics.drawPict("angel_chk", 350, 100);
    }
  }
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
  BoundingBox box = new BoundingBox(0, 0, 0, 0, 10);
 
  Player(int id) { this.id = id; }
  
  public void init(String imageName, char[] keys, int ix, int iy) {
    image = imageName;
    x = ix;
    y = iy;
    box._x = x;
    box._y = y;
    box._border = 10;
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
    if (!hasCollision(gModel.WALL) && !Collide(gModel.player1.box,gModel.player2.box)) {
      x = xtmp - box._border;
    }
    box._x = x + box._border;
    
    box._y = ytmp;
    if (!hasCollision(gModel.WALL) && !Collide(gModel.player1.box,gModel.player2.box)) {
      y = ytmp - box._border;
    } 
    box._y = y + box._border;
  }
  
  public Boolean hasCollision(int type) {
    if (Pause) return false;  
    // cast needed for javascript...
    int boxy = (int)((box._y - yHUD) / gridSize);
    int boxx = (int)(box._x / gridSize);
    int boxxx = (int)((box._x + box._width) / gridSize);
    int boxyy = (int)((box._y - yHUD + box._height) / gridSize);
    if (boxx >= 0 && boxy >=0 && boxx < gModel.nbxgrid && boxy < gModel.nbygrid && (gModel.grid[boxx][boxy] == type)) return true;
    if (boxxx >= 0 && boxy >=0 && boxxx < gModel.nbxgrid && boxy < gModel.nbygrid &&(gModel.grid[boxxx][boxy] == type)) return true;
    if (boxxx >= 0 && boxyy >=0 && boxxx < gModel.nbxgrid && boxyy < gModel.nbygrid &&(gModel.grid[boxxx][boxyy] == type)) return true;
    if (boxx >= 0 && boxyy >=0 && boxx < gModel.nbxgrid && boxyy < gModel.nbygrid &&(gModel.grid[boxx][boxyy] == type)) return true;
    return false;  
  }

  public void update(int dt) {
    int fKey = gModel.rule.getForbidenKey(id);
    if (fKey != -1 && gInputs.checkKey(keys[fKey])) { roundover("Player "+id+" loses"); changeScore(-10); }
    if (hasCollision(gModel.TRIGGER1))
      gModel.rule.trigger1.onTrigger.activate(id);      
    if (hasCollision(gModel.TRIGGER2))
      gModel.rule.trigger2.onTrigger.activate(id);

    int coef = -speed*dt/1000;
    int xSpeed = (gInputs.checkKey(keys[Direction.RIGHT])?1:0)*coef - (gInputs.checkKey(keys[Direction.LEFT])?1:0)*coef;
    int ySpeed = (gInputs.checkKey(keys[Direction.DOWN])?1:0)*coef - (gInputs.checkKey(keys[Direction.UP])?1:0)*coef;
    move(xSpeed, ySpeed);
  }
  
  public void changeScore(int iScore)
  {
    score += iScore;
    gGraphics.changeScore(id, iScore);
    Timer timer = new Timer();
    timer.releaseCallback = new Callback() { public void call() { gGraphics.endChangeScore(id); } };
    timer.releaseTime = millis() + 1000;
    timers.add(timer);
  }
  
  void draw() { 
    gGraphics.drawPict(image, x, y); 
  }
}

class CallbackTrigger {
  public void activate(int playerId) {}  
}

class TriggerArea {
  CallbackTrigger onTrigger = new CallbackTrigger(); 
}
