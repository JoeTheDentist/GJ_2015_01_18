
/**
 * Main file for the project.
 * Forwarder to main classes.
 */

Minim minim = new Minim(this);
int lastMs = millis();
Boolean Debug = false;


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
  int currMs = millis();
  int dt = lastMs - currMs;
  lastMs = currMs;
  gModel.update(dt);
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

