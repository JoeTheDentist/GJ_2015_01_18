import java.util.List;
import java.util.Iterator;
/**
 * Main file for the project.
 * Forwarder to main classes.
 */

class Callback {
    public void call() {}
}

class Timer {
    int releaseTime = 0;
    Callback releaseCallback = new Callback();
}

Minim minim = new Minim(this);
int lastMs = millis();
ArrayList<Timer> timers = new ArrayList<Timer>();
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
  
  Iterator<Timer> i = timers.iterator();
  while (i.hasNext()) {
    Timer timer = i.next();
    if (timer.releaseTime <= currMs ) {
      timer.releaseCallback.call();
      i.remove();
    }
  }
}

void roundover(String text) {
  gGraphics.roundover = text; 
  gInputs.clear();
  // pause
  Pause = true;
  Timer timer = new Timer();
  timer.releaseCallback = new Callback() { public void call() { Pause = false;  gGraphics.roundover = ""; gModel.reset(); } };
  timer.releaseTime = millis() + 3000;
  timers.add(timer);
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

