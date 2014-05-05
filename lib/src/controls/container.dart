part of valorzhong_bones;




abstract class Container extends Component {
  Layout _layout;
  Rectangle _bounds;
  bool _autoResize;

  Container([this._layout])
      : _autoResize = true,
        super() {
  }

  @override
  size(num width, num height) {
    _prepareBounds();
    _bounds.setTo(0, 0, width, height);
    _autoResize = false;
    invalidate();
  }

  Layout get defaultLayout => new EmptyLayout();

  Layout get layout => _layout;

  set layout(Layout val) {
    _layout = val;
    invalidate();
  }

  @override
  void set width(num val) {
    _prepareBounds();
    _bounds.width = val;
    _autoResize = false;
    invalidate();
  }

  @override
  void set height(num val) {
    _prepareBounds();
    _bounds.height = val;
    _autoResize = false;
    invalidate();
  }

  @override
  num get width {
    _prepareBounds();
    return _bounds.width;
  }

  @override
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
    if (_bounds == null) _bounds = new Rectangle(0, 0, 0, 0);
    if (_bounds.isEmpty) _bounds.setTo(0, 0, super.width, super.height);
  }

  order() {
    if (_layout == null) {
      _layout = defaultLayout;
    }
    _layout.order(this);
  }

  addChild(DisplayObject child) {
    super.addChild(child);
    invalidate();
  }

  @override
  render(RenderState renderState) {
    if (_invalid) {
      repaint();
      order();
      _invalid = false;
    }
    super.render(renderState);
  }
}


class Window extends Container {
  Window([Layout layout]): super(layout);
}
