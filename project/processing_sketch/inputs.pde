import java.util.HashSet;

Inputs gInputs = new Inputs();

class Inputs {
  
  private HashSet<Integer> keySet = new HashSet<Integer>();
  
  public void keyPressed(int ikey) {
    keySet.add(ikey);
  }
  
  public void keyReleased(int ikey) {
    keySet.remove(ikey);
  }
  
  public Boolean checkKey(int ikey) {
    return keySet.contains(ikey);
  }
}

