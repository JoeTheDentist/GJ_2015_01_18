
Inputs gInputs = new Inputs();

class Inputs {
  public void keyPressed(int key) {
    gSounds.play("plop");
    switch (key) {
      case 'i':
        println("UP");
        gModel.up();
        break;
      case 'k':
        println("DOWN");
        gModel.down();
        break;
      case 'j':
        println("LEFT");
        gModel.left();
        break;
      case 'l':
        println("RIGHT");
        gModel.right();
        break;
    }
  }
}

