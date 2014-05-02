part of valorzhong_bones;

typedef void ChildrenWalker(int, DisplayObject);

abstract class Component extends Sprite {

  Debugger _debugger;
  bool _invalid = true;
  bool get invalid => _invalid;
  
  invalidate() => _invalid = true;
  repaint() => _invalid = false;

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
  }
}

class Debugger {
  Component _cmp;
  Debugger(this._cmp);

  clear() => _cmp.graphics.clear();

  drawBackground([int color = Color.Red]) {
    _cmp.graphics
        ..rect(0, 0, _cmp.width, _cmp.height)
        ..fillColor(color);
  }

  drawBorder([int color = Color.Red]) {
    _cmp.graphics
        ..rect(0, 0, _cmp.width, _cmp.height)
        ..strokeColor(color);
  }
}
