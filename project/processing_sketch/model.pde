
CustomRect global_rect = new CustomRect();

/**
 * Initialize model
 */
void init_model() {
  
}

void up_model() {
  global_rect.up();
}

void down_model() {
  global_rect.down();
}

void left_model() {
  global_rect.left();
}

void right_model() {
  global_rect.right();
}

CustomRect get_rect() { return global_rect; }

class CustomRect {
  int x = 0;
  int y = 0;
  
  void up() { y -= 10; }
  void down() { y += 10; }
  void left() { x -= 10; }
  void right() { x += 10; }
  void draw_me() { draw_rect(x, y); }
}
