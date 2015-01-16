
Graphics gGraphics = new Graphics();

class Graphics {
  public void init() {
    size(800,600);
    background(0);
  }
  
  public void draw() {
    background(0);
    noStroke();
    colorMode(RGB, 100);
    gModel.getRect().draw_me();
  }
  
  public void drawPict(String imgName, int x, int y) {
    image(gResources.getImage(imgName), x, y);
  }
}
