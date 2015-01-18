import java.util.List;

ArrayList<BoundingBox> gBoxes = new ArrayList<BoundingBox>();

class BoundingBox {
  int _x;
  int _y;
  int _width;
  int _height;
  int _border;
  
  public BoundingBox(int x, int y, int iwidth, int iheight, int iborder) {
    this._x = x;
    this._y = y;
    this._width = iwidth;
    this._height = iheight;
    this._border = iborder;
    gBoxes.add(this);
  }
  
  public void draw() {
    noStroke();
    fill(256, 0, 0, 50);
    rect(_x, _y, _width, _height);
  }

}

static public Boolean Collide (BoundingBox box1, BoundingBox box2) {
  return !( (box1._x+box1._width-1 < box2._x || box1._x > box2._x+box2._width-1) || ( box1._y+box1._height-1 < box2._y || box1._y > box2._y+box2._height-1 ) );
}

