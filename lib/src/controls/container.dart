part of bones;




abstract class Container extends Component {
  Layout _layout;
  bool _autoResize;

  Container([this._layout])
      : _autoResize = true,
        super();

  @override
  size(num width, num height) {
    super.size(width, height);
    _autoResize = false;
    _fireResize();
  }

  Layout get defaultLayout => new EmptyLayout();

  Layout get layout => _layout;

  set layout(Layout val) {
    _layout = val;
    invalidate();
  }

  @override
  void set width(num val) {
    super.width = val;
    _autoResize = false;
    _fireResize();
  }

  @override
  void set height(num val) {
    super.height = val;
    _autoResize = false;
    _fireResize();
  }

  bool get autoResize => _autoResize;

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
    if (_dirty) {
      repaint();
      order();
      _dirty = false;
    }
    super.render(renderState);
  }

  _fireResize() => dispatchEvent(new Event(Event.RESIZE));
}


class Window extends Container {
  Window([Layout layout]): super(layout);
}
