part of valorzhong_bones;

typedef void ChildrenWalker(int, DisplayObject);

abstract class Component extends Sprite {

  _Debugger _debugger;
  bool _invalid = true;
  bool get invalid => _invalid;

  invalidate() => _invalid = true;
  // TODO : this name should be changed ?
  repaint() => _invalid = false;

  // TODO : not yet
  measure() {}

  @override
  render(RenderState renderState) {
    if (_invalid) {
      _invalid = false;
      repaint();
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

  _Debugger get debugger {
    if (_debugger == null) {
      _debugger = new _Debugger(this);
    }
    return _debugger;
  }
}

class Box extends Component {
  Box([num w = 100, num h = 100, int color = Color.Red]) {
    graphics
        ..rect(0, 0, w, h)
        ..fillColor(color);
  }
}

class _Debugger {
  Component _cmp;
  _Debugger(this._cmp);

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
