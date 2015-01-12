
void setup() {
  size(800,600);
  background(0);
  println("Hello");
}

void draw() {
  noStroke();
  colorMode(RGB, 100);
}

void keyPressed() {
  switch (key) {
    case 'i':
      println("UP");
      break;
    case 'k':
      println("DOWN");
      break;
    case 'j':
      println("LEFT");
      break;
    case 'l':
      println("RIGHT");
      break;
  }
}
