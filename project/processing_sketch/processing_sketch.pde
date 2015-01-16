
/**
 * Main file for the project.
 * Forwarder to main classes.
 */

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
  gGraphics.draw();
}

/**
 * Keyboard action
 */
void keyPressed() {
  gInputs.keyPressed(key);
}
