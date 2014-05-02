part of valorzhong_bones;




abstract class Container extends Component {
  Layout _layout;
  Rectangle _bounds;
  bool _autoResize;

  Container([this._layout]): super() {
    if (_layout == null) {
      _layout = new EmptyLayout();
    }
    _autoResize = true;
  }

  setSize(num width, num height) {
    if (_bounds == null) {
      _bounds = new Rectangle(0, 0, 0, 0);
    }
    _bounds.setTo(0, 0, width, height);
    _autoResize = false;
    invalidate();
  }

  Layout get layout => _layout;

  set layout(Layout val) {
    _layout = val;
    invalidate();
  }

  num get width {
    _prepareBounds();
    return _bounds.width;
  }

  num get height {
    _prepareBounds();
    return _bounds.height;
  }

  Rectangle get bounds {
    _prepareBounds();
    return _bounds;
  }

  bool get autoResize => _autoResize;

  _prepareBounds() {
    if (_bounds == null || _bounds.isEmpty) {
      setSize(super.width, super.height);
    }
  }

  order() {
    _layout.order(this);
  }

  addChild(DisplayObject child) {
    super.addChild(child);
    invalidate();
  }

  @override
  repaint() {
    super.repaint();
    order();
  }
}


class Window extends Container {
  Window([Layout layout]): super(layout);
}
