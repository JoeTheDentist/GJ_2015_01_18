import java.util.List;

ArrayList<BoundingBox> gBoxes = new ArrayList<BoundingBox>();

class BoundingBox {
  int _x;
  int _y;
  int _width;
  int _height;
  
  public BoundingBox(int x, int y, int iwidth, int iheight) {
    this._x = x;
    this._y = y;
    this._width = iwidth;
    this._height = iheight;
    gBoxes.add(this);
  }
}

static public Boolean CollideX (BoundingBox box1, BoundingBox box2) {
  return !( box1._x+box1._width-1 < box2._x || box1._x > box2._x+box2._width-1 );
}

static public Boolean CollideY (BoundingBox box1, BoundingBox box2) {
  return !( box1._y+box1._height-1 < box2._y || box1._y > box2._y+box2._height-1 ) ;
}

static public Boolean Collide (BoundingBox box1, BoundingBox box2) {
  return CollideX(box1, box2) || CollideY(box1, box2);
}
