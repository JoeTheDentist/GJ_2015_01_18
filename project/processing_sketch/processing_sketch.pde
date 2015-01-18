
/**
 * Main file for the project.
 * Forwarder to main classes.
 */

class Callback {
    public void call() {}
}


Minim minim = new Minim(this);
int lastMs = millis();
int releaseTime = 0;
Callback releaseCallback = new Callback();
Boolean Debug = false;
Boolean Pause = false;

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
  
  if (Pause && releaseTime <= currMs) { 
    println("End pause"); 
    Pause = false; 
    releaseCallback.call();
  }
}

void roundover(String text) {
  gGraphics.roundover = text; 
  gInputs.clear();
  pause(3000, new Callback() { public void call() { gGraphics.roundover = ""; gModel.reset(); } } );
}

void pause(int time, Callback callback) {
  println("Pause " + time);
  Pause = true;
  releaseCallback = callback;
  releaseTime = millis() + time;
}

/**
 * Keyboard action
 */
void keyPressed() {
  if (!Pause)
    gInputs.keyPressed(key);
}

void keyReleased() {
  gInputs.keyReleased(key);
}

