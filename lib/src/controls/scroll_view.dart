part of bones;


class ScrollView extends Component {
  static const OVER_SCROLL_ALWAYS = 0;
  static const OVER_SCROLL_IF_CONTENT_SCROLLS = 1;
  static const OVER_SCROLL_NEVER = 2;

  int _overScrollModel = OVER_SCROLL_IF_CONTENT_SCROLLS;
  bool horizontalScrollToMax = false;
  bool verticalScrollToMax = false;
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
    onTouchBegin.listen(_startDrag);
    onMouseDown.listen(_startDrag);
  }

  void _startDrag(e) {
    if (stage != null) {
      _stopScrolling();
      _lastPos.setTo(e.stageX, e.stageY);
      stage.onTouchMove.listen(_stageMoveHandler);
      stage.onTouchEnd.listen(_stageUpHandler);
      stage.onMouseMove.listen(_stageMoveHandler);
      stage.onMouseUp.listen(_stageUpHandler);
    }
  }

  void _stopScrolling() {
    _showScrollBars();
    stage.removeEventListener(TouchEvent.TOUCH_MOVE, _stageMoveHandler);
    stage.removeEventListener(TouchEvent.TOUCH_END, _stageUpHandler);
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, _stageMoveHandler);
    stage.removeEventListener(MouseEvent.MOUSE_UP, _stageUpHandler);
  }

  void _stageMoveHandler(e) {
    var delta = new Point(e.stageX, e.stageY) - _lastPos;
    scrollTo(_content.x + delta.x, _content.y + delta.y);
    _lastPos.setTo(e.stageX, e.stageY);
  }

  void _stageUpHandler(e) {
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
    _content.on(Event.RESIZE).listen((e) {
      _adjustViewport();
      _scrollToMax();
    });

    addChildAt(_content, 0);
    _adjustViewport();
    _scrollToMax();
  }

  _scrollToMax() {
    if (_content == null) return;
    var sx = 0,
        sy = 0;
    if (horizontalScrollToMax) {
      sx = width - _content.width;
    }
    if (verticalScrollToMax) {
      sy = height - _content.height;
    }
    scrollTo(sx, sy);
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
    if (_overScrollModel == OVER_SCROLL_IF_CONTENT_SCROLLS) return _content != null ? _content.width > width : false;
    return false;
  }

  bool get vbarVisible {
    if (_overScrollModel == OVER_SCROLL_ALWAYS) return true;
    if (_overScrollModel == OVER_SCROLL_IF_CONTENT_SCROLLS) return _content != null ? _content.height > height : false;
    return false;
  }
}
