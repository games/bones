part of valorzhong_bones;

typedef void ChildrenWalker(int, DisplayObject);

class Component extends Sprite {

  num _width, _height;
  Debugger _debugger;
  bool _dirty = true;
  bool get dirty => _dirty;

  Component()
      : _width = 0,
        _height = 0 {
    initialize();
  }

  initialize() {}

  invalidate() => _dirty = true;

  // TODO : this name should be changed ?
  repaint() {}

  measure() {
    if (_width == 0) _width = super.width;
    if (_height == 0) _height = super.height;
    // TODO : Is this necessary ?
    //    forEach((i, child) {
    //      if (child is Component) child.measure();
    //    });
  }

  @override
  void set width(num val) {
    _width = val;
    invalidate();
  }

  num get width => _width == 0 ? super.width : _width;

  @override
  void set height(num val) {
    _height = val;
    invalidate();
  }

  num get height => _height == 0 ? super.height : _height;

  size(num width, num height) => this
      ..width = width
      ..height = height;

  zoom(num val) => this
      ..scaleX = val
      ..scaleY = val;

  move(num x, num y) => this
      ..x = x
      ..y = y;

  @override
  render(RenderState renderState) {
    if (_dirty) {
      repaint();
      _dirty = false;
    }
    super.render(renderState);
  }

  destroy() {
    forEach((i, child) {
      if (child is Component) {
        child.destroy();
      }
    });
  }

  forEach(ChildrenWalker walker) {
    var num = numChildren;
    for (var i = 0; i < num; i++) {
      walker(i, getChildAt(i));
    }
  }

  Debugger get debugger {
    if (_debugger == null) {
      _debugger = new Debugger(this);
    }
    return _debugger;
  }
}

class Box extends Component {
  Box([num w = 100, num h = 100, int color = Color.Red]) {
    graphics
        ..rect(0, 0, w, h)
        ..fillColor(color);
    measure();
    applyCache(0, 0, w, h);
  }
}

class Debugger {
  Component _cmp;
  Debugger(this._cmp);

  clear() => _cmp.graphics.clear();

  drawBackground([int color = Color.Red, Rectangle rect = null]) {
    if (rect == null) {
      rect = new Rectangle(0, 0, _cmp.width, _cmp.height);
    }
    _cmp.graphics
        ..rect(rect.left, rect.top, rect.width, rect.height)
        ..fillColor(color);
  }

  drawBorder([int color = Color.Red, Rectangle rect = null]) {
    if (rect == null) {
      rect = new Rectangle(0, 0, _cmp.width, _cmp.height);
    }
    _cmp.graphics
        ..rect(rect.left, rect.top, rect.width, rect.height)
        ..strokeColor(color);
  }
}
