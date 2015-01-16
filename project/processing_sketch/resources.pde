
import java.util.Map;

Resources gResources = new Resources();

class Resources {
  public void init() {
    getImage("plop");
  }
  
  public PImage getImage(String name) {
    if (!imageMap.containsKey(name)) {
      imageMap.put(name, loadImage(resourcesImagePath + name + ".png"));
    }
    return imageMap.get(name);
  }

  private HashMap<String, PImage> imageMap = new HashMap<String, PImage>();
  private static final String resourcesRootPath = "../resources/";
  private static final String resourcesImagePath = Resources.resourcesRootPath + "images/";
}



