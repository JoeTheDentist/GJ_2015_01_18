
Graphics gGraphics = new Graphics();

int xWindow = 800;
int yWindow = 800;
int yHUD = 211;

class Graphics {
  String roundover = "";
  
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
    fill(255, 255, 255);
    text(gModel.player1.score, 75 ,175);
  
    //Score Player 2
    fill(255, 255, 255);
    text(gModel.player2.score, 675 ,175);
  }
  
  public void drawRoundover() {
    if (!roundover.isEmpty()) {
      fill(255, 255, 255);
      text("ROUND OVER" + "\n" + roundover, 280 , 500); 
    }
  }
}

class Animation {
  Animation(String pathToImgs, int numberOfImgs) {}
  void update(float dt) {}
}
