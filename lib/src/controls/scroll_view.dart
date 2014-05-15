part of bones;


class ScrollView extends Component {
  static const OVER_SCROLL_ALWAYS = 0;
  static const OVER_SCROLL_IF_CONTENT_SCROLLS = 1;
  static const OVER_SCROLL_NEVER = 2;

  int _overScrollModel = OVER_SCROLL_ALWAYS;
  DisplayObject _content;
  Point _lastPos;
  int _backgroundColor = Color.White;
  ScrollBar _hbar, _vbar;
  Point<num> _viewport;

  ScrollView(): super() {
    _hbar = new ScrollBar(orientation: Orientation.HORIZONTAL)..visible = false;
    addChild(_hbar);
    _vbar = new ScrollBar(orientation: Orientation.VERTICAL)..visible = false;
    addChild(_vbar);
    _viewport = new Point(0, 0);
    _lastPos = new Point(0, 0);
    on(Event.RESIZE).listen(_resizeHandler);
  }

  @override
  initialize() {
    super.initialize();
    onMouseDown.listen((e) {
      if (stage != null) {
        _stopScrolling();
        _lastPos.setTo(e.stageX, e.stageY);
        stage.onMouseMove.listen(_stageMouseMoveHandler);
        stage.onMouseUp.listen(_stageMouseUpHandler);
      }
    });
  }

  void _stopScrolling() {
    _showScrollBars();
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, _stageMouseMoveHandler);
    stage.removeEventListener(MouseEvent.MOUSE_UP, _stageMouseUpHandler);
  }

  void _stageMouseMoveHandler(MouseEvent e) {
    var delta = new Point(e.stageX, e.stageY) - _lastPos;
    scrollTo(_content.x + delta.x, _content.y + delta.y);
    _lastPos.setTo(e.stageX, e.stageY);
  }

  void _stageMouseUpHandler(e) {
    _stopScrolling();
  }

  void _resizeHandler(Event event) {
    mask = new Mask.rectangle(0, 0, width, height);
    if (_content != null) {
      _adjustViewport();
      scrollTo(_content.x, _content.y);
    }
  }

  void scrollTo(num x, num y) {
    _content
        ..x = Math.min(Math.max(_viewport.x, x), 0)
        ..y = Math.min(Math.max(_viewport.y, y), 0);
    _hbar.value = _content.x / _viewport.x * _content.width;
    _vbar.value = _content.y / _viewport.y * _content.height;
  }

  @override
  repaint() {
    super.repaint();
    if (_backgroundColor != null) {
      graphics
          ..clear()
          ..rect(0, 0, _width, _height)
          ..fillColor(_backgroundColor);
    }
  }

  DisplayObject get content => _content;

  void set content(DisplayObject val) {
    if (_content != null) {
      _content.on(Event.RESIZE).cancelSubscriptions();
      removeChild(_content);
    }
    _content = val;
    _content.on(Event.RESIZE).listen((e) => _adjustViewport());
    addChildAt(_content, 0);
    _adjustViewport();
  }

  int get backgroundColor => _backgroundColor;

  set backgroundColor(int val) {
    _backgroundColor = val;
    invalidate();
  }

  void _adjustViewport() {
    var cw = _content.width;
    var ch = _content.height;
    _viewport.setTo(width - cw, height - ch);
    _hbar
        ..width = width
        ..y = height - _hbar.height
        ..range = width
        ..maximum = cw;
    _vbar
        ..height = height
        ..x = width - _vbar.width
        ..range = height
        ..maximum = ch;
    _showScrollBars();
  }

  _showScrollBars() {
    _hbar.visible = hbarVisible;
    _vbar.visible = vbarVisible;
  }

  int get overScrollModel => _overScrollModel;

  void set overScrollModel(int val) {
    _overScrollModel = val;
    _showScrollBars();
  }

  bool get hbarVisible {
    if (_overScrollModel == OVER_SCROLL_ALWAYS) return true;
    if (_overScrollModel == OVER_SCROLL_IF_CONTENT_SCROLLS) return _content.width > width;
    return false;
  }

  bool get vbarVisible {
    if (_overScrollModel == OVER_SCROLL_ALWAYS) return true;
    if (_overScrollModel == OVER_SCROLL_IF_CONTENT_SCROLLS) return _content.height > height;
    return false;
  }
}
