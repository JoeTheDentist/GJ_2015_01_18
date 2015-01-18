
Graphics gGraphics = new Graphics();

int xWindow = 800;
int yWindow = 800;
int yHUD = 210;

class Graphics {
  public void init() {
    size(xWindow, yWindow);
    background(0);
  }
  
  public void draw() {
    drawPict("background", 0, 0);
    gModel.draw_me();
    drawPict("hud", 0, 0);
  }
  
  public void drawPict(String imgName, int x, int y) {
    image(gResources.getImage(imgName), x, y);
  }
}
