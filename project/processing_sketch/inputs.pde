// HashSet not supported in Processing.js
import java.util.HashMap;

Inputs gInputs = new Inputs();

class Inputs {
  
  private HashMap<Integer, Boolean> keySet = new HashMap<Integer, Boolean>();
  
  public void keyPressed(int ikey) {
    keySet.put(ikey, true);
  }
  
  public void keyReleased(int ikey) {
    keySet.remove(ikey);
  }
  
  public Boolean checkKey(int ikey) {
    return keySet.containsKey(ikey);
  }
  
  public void clear(){
     keySet.clear(); 
  }
}

