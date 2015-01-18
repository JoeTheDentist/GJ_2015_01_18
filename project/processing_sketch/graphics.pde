
Graphics gGraphics = new Graphics();

class Graphics {
  public void init() {
    size(800,800);
    background(0);
  }
  
  public void draw() {
    drawPict("background", 0, 0);
    gModel.draw_me();
  }
  
  public void drawPict(String imgName, int x, int y) {
    image(gResources.getImage(imgName), x, y);
  }
}
