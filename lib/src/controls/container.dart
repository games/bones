part of valorzhong_bones;




abstract class Container extends Component {
  Layout _layout;
  Rectangle _bounds;

  Container([this._layout]): super() {
    if (_layout == null) {
      _layout = new EmptyLayout();
    }
  }

  setSize(num width, num height) {
    if (_bounds == null) {
      _bounds = new Rectangle(0, 0, 0, 0);
    }
    _bounds.setTo(x, y, width, height);
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

  _prepareBounds() {
    if (_bounds == null) {
      setSize(super.width, super.height);
    }
  }

  layout() {
    _layout.order(this);
  }

  addChild(DisplayObject child) {
    super.addChild(child);
    invalidate();
  }

  @override
  repaint() {
    layout();
  }
}


class Window extends Container {
  Window([Layout layout]): super(layout);
}
