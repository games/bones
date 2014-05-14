part of bones;

typedef void ChildrenWalker(int, DisplayObject);


/*
 * component lifecycle:
 * 
 * -> instantiation from new()
 * ->   onAddedToStage call initialize
 * 
 * -> initialize(only first time)
 *    -> should calculate width and height
 * 
 * -> render
 *      if (dirty)  repaint()
 *      
 * -> invalidate
 *      dirty = true 
 *      
 * -> destroy
 * 
 */

class Component extends Sprite {

  num _width, _height;
  Debugger _debugger;
  bool _dirty = false;
  bool get dirty => _dirty;
  Once _initializer;

  Component() {
    _initializer = new Once(initialize);
    onAddedToStage.listen((e) => _initializer.execute());
  }

  initialize() {
  }

  invalidate() => _dirty = true;
  validate() => _dirty = false;

  // TODO : this name should be changed ?
  repaint() {}

  measure() {
    _initializer.execute();
    if (_width == null) _width = super.width;
    if (_height == null) _height = super.height;
  }

  @override
  void set width(num val) {
    _width = val;
    invalidate();
  }

  num get width {
    if (_width == null) measure();
    return _width;
  }

  @override
  void set height(num val) {
    _height = val;
    invalidate();
  }

  num get height {
    if (_height == null) measure();
    return _height;
  }

  size(num width, num height) => this
      ..width = width
      ..height = height;

  zoom(num val) => this
      ..scaleX = val
      ..scaleY = val;

  move(num x, num y) => this
      ..x = x
      ..y = y;
  
  toggle() => visible = !visible;

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
