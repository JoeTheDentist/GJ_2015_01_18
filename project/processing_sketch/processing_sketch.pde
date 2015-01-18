
/**
 * Main file for the project.
 * Forwarder to main classes.
 */

Minim minim = new Minim(this);
Integer playerSpeed = 5;

/**
 * Init function
 */
void setup() {
  gResources.init();
  gGraphics.init();
  gModel.init();
}

/**
 * Builtin refresh loop
 */
void draw() {
  handleMove();
  gGraphics.draw();
}

/**
 * Keyboard action
 */
void keyPressed() {
  gInputs.keyPressed(key);
}

void keyReleased() {
  gInputs.keyReleased(key);
}

void handleMove() {
 // player 1
 int xSpeed = (gInputs.checkKey('d')?1:0)*playerSpeed - (gInputs.checkKey('q')?1:0)*playerSpeed;
 int ySpeed = (gInputs.checkKey('s')?1:0)*playerSpeed - (gInputs.checkKey('z')?1:0)*playerSpeed;
 gModel.player1.move(xSpeed, ySpeed);
 // player 2 
 xSpeed = (gInputs.checkKey('l')?1:0)*playerSpeed - (gInputs.checkKey('j')?1:0)*playerSpeed;
 ySpeed = (gInputs.checkKey('k')?1:0)*playerSpeed - (gInputs.checkKey('i')?1:0)*playerSpeed;
 gModel.player2.move(xSpeed, ySpeed);
}
