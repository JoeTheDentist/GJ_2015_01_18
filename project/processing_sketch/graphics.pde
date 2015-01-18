
Graphics gGraphics = new Graphics();

int xWindow = 800;
int yWindow = 800;
int yHUD = 211;

class Graphics {
  String roundover = "";
  int player1ScoreChanging = 0;
  int player2ScoreChanging = 0;
  
  public void init() {
    textSize(40);
    colorMode(RGB, 255);
    size(xWindow, yWindow);
    background(0);
  }
  
  public void draw() {    
    drawPict("background", 0, 0);
    gModel.draw();
    if (Debug) { drawGrid(); }
    drawPict("hud", 0, 0);
    gModel.rule.draw();
    drawScores();
    drawRoundover();
  }
  
  public void drawGrid() {
    for (int y = yHUD; y < yWindow; y+= gridSize) {
      line(0, y, xWindow, y);  
    }
    for (int x = 0; x < xWindow; x+= gridSize) {
      line(x, 0, x, xWindow);  
    }
  }
  
  public void drawPict(String imgName, int x, int y) {
    image(gResources.getImage(imgName), x, y);
  }
  
  public void drawScores() {
    //Score Player 1
    fill(255, 0, 0);
    text(gModel.player1.score, 75 ,175);
    if (player1ScoreChanging != 0) {
      String sign = player1ScoreChanging>0?"+":"";
      text(sign + player1ScoreChanging, 125 ,205);
    }
  
    //Score Player 2
    fill(0, 0, 255);
    text(gModel.player2.score, 675 ,175);
    if (player2ScoreChanging != 0) {
      String sign = player2ScoreChanging>0?"+":"";
      text(sign + player2ScoreChanging, 725, 205);
    }
  }
  
  public void drawRoundover() {
    if (!roundover.isEmpty()) {
      fill(255, 255, 255);
      text("ROUND OVER" + "\n" + roundover, 280 , 500); 
    }
  }
  
  public void changeScore(int playerId, int score) {
    if (playerId == 1) {
      player1ScoreChanging = score; 
    }
    if (playerId == 2) {
      player2ScoreChanging = score; 
    }
  }
  
  public void endChangeScore(int playerId) {
    if (playerId == 1) {
      player1ScoreChanging = 0; 
    }
    if (playerId == 2) {
      player2ScoreChanging = 0; 
    }
  }
}

class Animation {
  Animation(String pathToImgs, int numberOfImgs) {}
  void update(float dt) {}
}
