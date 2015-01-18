
import java.util.Map;
import ddf.minim.*;

Resources gResources = new Resources();

class Resources {
  public void init() {
    getImage("chk_blu");
    getImage("chk_red");
    getImage("background");
    getImage("hud");
    getSound("plop");
  }
  
  public PImage getImage(String name) {
    if (!imageMap.containsKey(name)) {
      imageMap.put(name, loadImage(resourcesImagePath + name + ".png"));
    }
    return imageMap.get(name);
  }
  
  public AudioPlayer getSound(String name) {
    if (!soundMap.containsKey(name)) {
      soundMap.put(name, minim.loadFile(resourcesSoundPath + name + ".mp3"));
    }
    return soundMap.get(name);
  }

  private HashMap<String, PImage> imageMap = new HashMap<String, PImage>();
  private HashMap<String, AudioPlayer> soundMap = new HashMap<String, AudioPlayer>();
  private static final String resourcesRootPath = "../resources/";
  private static final String resourcesImagePath = Resources.resourcesRootPath + "images/";
  private static final String resourcesSoundPath = Resources.resourcesRootPath + "sounds/";
}



