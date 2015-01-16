
Model gModel = new Model();

class Model {
  
  public void init() {
    
  }
  
  public void up() {
    rect.up();
  }
  
  public void down() {
    rect.down();
  }
  
  public void left() {
    rect.left();
  }
  
  public void right() {
    rect.right();
  }
  
  public CustomRect getRect() {
    return rect;
  }
  
  private CustomRect rect = new CustomRect();
}

class CustomRect {
  int x = 0;
  int y = 0;
  
  void up() { y -= 10; }
  void down() { y += 10; }
  void left() { x -= 10; }
  void right() { x += 10; }
  void draw_me() { gGraphics.drawPict("plop", x, y); }
}
