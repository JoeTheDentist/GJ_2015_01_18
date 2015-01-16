
/**
 * Capture keyboard actions
 * (async)
 */
void keyPressed() {
  switch (key) {
    case 'i':
      println("UP");
      up_model();
      break;
    case 'k':
      println("DOWN");
      down_model();
      break;
    case 'j':
      println("LEFT");
      left_model();
      break;
    case 'l':
      println("RIGHT");
      right_model();
      break;
  }
}

