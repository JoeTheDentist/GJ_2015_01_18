
Sounds gSounds = new Sounds();

class Sounds {
  void play(String soundName) {
    gResources.getSound(soundName).rewind();
    gResources.getSound(soundName).play();
  }
  
  void playLoop(String soundName) {
    gResources.getSound(soundName).play();
    gResources.getSound(soundName).loop();
  }
  
  void stop(String soundName) {
    gResources.getSound(soundName).pause();
  }
}

