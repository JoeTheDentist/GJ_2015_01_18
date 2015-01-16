
/**
 * Initialize graphics
 * Define windows size and background
 */
void init_graphics() {
  size(800,600);
  background(0);
}

/**
 * Refresh graphics
 */
void draw_graphics() {
  background(0);
  noStroke();
  colorMode(RGB, 100);
  get_rect().draw_me();
}

void draw_rect(int x, int y) {
  fill(100,0,100);
  rect(x, y, 55, 55);
}

