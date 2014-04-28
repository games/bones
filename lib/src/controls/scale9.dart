part of valorzhong_bones;


class Scale9Bitmap extends Component {
  Sprite _holder;
  Scale9Texture _texture;

  Scale9Bitmap(this._texture) {
    _holder = new Sprite();
    addChild(_holder);
    _width = _texture.source.width;
    _height = _texture.source.height;
    mouseChildren = false;
  }

  num _width, _height;
  num get width => _width;
  num get height => _height;

  set width(num val) {
    _width = val;
    _invalidate = true;
  }

  set height(num val) {
    _height = val;
    _invalidate = true;
    super.height = val;
  }

  set texture(Scale9Texture val) {
    _texture = val;
    _invalidate = true;
  }

  Rectangle getBoundsTransformed(Matrix matrix, [Rectangle returnRectangle]) {
    return _getBoundsTransformedHelper(matrix, _width, _height, returnRectangle);
  }

  repaint() {
    var mx = _texture.scale9Grid.left;
    var my = _texture.scale9Grid.top;
    var sx = (_width - (_texture.source.width - _texture.scale9Grid.width)) / _texture.scale9Grid.width;
    var sy = (_height - (_texture.source.height - _texture.scale9Grid.height)) / _texture.scale9Grid.height;
    _holder.removeChildren();

    _holder.addChild(_texture.topLeft);
    var tc = _texture.topCenter;
    tc.x = mx;
    tc.scaleX = sx;
    _holder.addChild(tc);
    var tr = _texture.topRight;
    tr.x = mx + tc.width;
    _holder.addChild(tr);

    var ml = _texture.middleLeft;
    ml.y = my;
    ml.scaleY = sy;
    _holder.addChild(ml);
    var mc = _texture.middleCenter;
    mc.x = mx;
    mc.y = my;
    mc.scaleX = sx;
    mc.scaleY = sy;
    _holder.addChild(mc);
    var mr = _texture.middleRight;
    mr.x = mx + mc.width;
    mr.y = my;
    mr.scaleY = sy;
    _holder.addChild(mr);

    var bl = _texture.bottomLeft;
    bl.y = my + ml.height;
    _holder.addChild(bl);
    var bc = _texture.bottomCenter;
    bc.x = mx;
    bc.y = bl.y;
    bc.scaleX = sx;
    _holder.addChild(bc);
    var br = _texture.bottomRight;
    br.x = mx + bc.width;
    br.y = my + mc.height;
    _holder.addChild(br);

    applyCache(0, 0, _width, _height);
  }
}


class Scale9Texture {
  BitmapData _source;
  Rectangle _scale9Grid;

  Bitmap _topLeft;
  Bitmap _topCenter;
  Bitmap _topRight;

  Bitmap _middleLeft;
  Bitmap _middleCenter;
  Bitmap _middleRight;

  Bitmap _bottomLeft;
  Bitmap _bottomCenter;
  Bitmap _bottomRight;

  Scale9Texture(this._source, this._scale9Grid) {
    var rightWidth = _source.width - _scale9Grid.right;
    var bottomHeight = _source.height - _scale9Grid.bottom;

    _topLeft = _slice(new Rectangle(0, 0, _scale9Grid.left, _scale9Grid.top));
    _topCenter = _slice(new Rectangle(_scale9Grid.left, 0, _scale9Grid.width, _scale9Grid.top));
    _topRight = _slice(new Rectangle(_scale9Grid.right, 0, rightWidth, _scale9Grid.top));

    _middleLeft = _slice(new Rectangle(0, _scale9Grid.top, _scale9Grid.left, _scale9Grid.height));
    _middleCenter = _slice(new Rectangle(_scale9Grid.left, _scale9Grid.top, _scale9Grid.width, _scale9Grid.height));
    _middleRight = _slice(new Rectangle(_scale9Grid.right, _scale9Grid.top, rightWidth, _scale9Grid.height));

    _bottomLeft = _slice(new Rectangle(0, _scale9Grid.bottom, _scale9Grid.left, bottomHeight));
    _bottomCenter = _slice(new Rectangle(_scale9Grid.left, _scale9Grid.bottom, _scale9Grid.width, bottomHeight));
    _bottomRight = _slice(new Rectangle(_scale9Grid.right, _scale9Grid.bottom, rightWidth, bottomHeight));
  }

  Bitmap _slice(Rectangle bound) => new Bitmap(new BitmapData.fromBitmapData(_source, bound));

  BitmapData get source => _source;
  Rectangle get scale9Grid => _scale9Grid;

  Bitmap get topLeft => _topLeft;
  Bitmap get topCenter => _topCenter;
  Bitmap get topRight => _topRight;

  Bitmap get middleLeft => _middleLeft;
  Bitmap get middleCenter => _middleCenter;
  Bitmap get middleRight => _middleRight;

  Bitmap get bottomLeft => _bottomLeft;
  Bitmap get bottomCenter => _bottomCenter;
  Bitmap get bottomRight => _bottomRight;
}


Rectangle _getBoundsTransformedHelper(Matrix matrix, num width, num height, Rectangle<num> returnRectangle) {

  width = width.toDouble();
  height = height.toDouble();

  // tranformedX = X * matrix.a + Y * matrix.c + matrix.tx;
  // tranformedY = X * matrix.b + Y * matrix.d + matrix.ty;

  num x1 = 0.0;
  num y1 = 0.0;
  num x2 = width * matrix.a;
  num y2 = width * matrix.b;
  num x3 = width * matrix.a + height * matrix.c;
  num y3 = width * matrix.b + height * matrix.d;
  num x4 = height * matrix.c;
  num y4 = height * matrix.d;

  num left = x1;
  if (left > x2) left = x2;
  if (left > x3) left = x3;
  if (left > x4) left = x4;

  num top = y1;
  if (top > y2) top = y2;
  if (top > y3) top = y3;
  if (top > y4) top = y4;

  num right = x1;
  if (right < x2) right = x2;
  if (right < x3) right = x3;
  if (right < x4) right = x4;

  num bottom = y1;
  if (bottom < y2) bottom = y2;
  if (bottom < y3) bottom = y3;
  if (bottom < y4) bottom = y4;

  if (returnRectangle != null) {
    returnRectangle.setTo(matrix.tx + left, matrix.ty + top, right - left, bottom - top);
  } else {
    returnRectangle = new Rectangle<num>(matrix.tx + left, matrix.ty + top, right - left, bottom - top);
  }

  return returnRectangle;
}
