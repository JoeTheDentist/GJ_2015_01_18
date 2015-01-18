
import java.util.Map;
import ddf.minim.*;

Resources gResources = new Resources();

class Resources {
  public void init() {
    getImage("chk_blu");
    getImage("chk_red");
    getImage("background");
    getImage("hud");
    getImage("not_round");
    getImage("not_line");
    getImage("rule_down_blu");
    getImage("rule_down_red");
    getImage("rule_up_blu");
    getImage("rule_up_red");
    getImage("rule_left_blu");
    getImage("rule_left_red");
    getImage("rule_right_blu");
    getImage("rule_right_red");
    getImage("egg");
    getSound("plop");
  }
  
  public String getArrowName(int playerId, int dir) {
    return "rule_"+direction[dir]+"_"+player[playerId-1];
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
  private final String[] direction = {"up", "down", "left", "right"};
  private final String[] player = {"red", "blu"};
  private static final String resourcesRootPath = "../resources/";
  private static final String resourcesImagePath = Resources.resourcesRootPath + "images/";
  private static final String resourcesSoundPath = Resources.resourcesRootPath + "sounds/";
}



