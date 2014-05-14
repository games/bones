part of bones;


class ScrollView extends Container {
  static const OVER_SCROLL_ALWAYS = 0;
  static const OVER_SCROLL_IF_CONTENT_SCROLLS = 1;
  static const OVER_SCROLL_NEVER = 2;

  int _overScrollModel = OVER_SCROLL_ALWAYS;
  Sprite _content;
  Point _lastPos;
  int _backgroundColor = Color.White;
  ScrollBar _hbar, _vbar;
  Point<num> _viewport;

  ScrollView(): super() {
    _hbar = new ScrollBar(orientation: Orientation.HORIZONTAL)..visible = false;
    super.addChildAt(_hbar, 0);
    _vbar = new ScrollBar(orientation: Orientation.VERTICAL)..visible = false;
    super.addChildAt(_vbar, 0);
    _content = new Sprite();
    super.addChildAt(_content, 0);
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
    _adjustViewport();
    scrollTo(_content.x, _content.y);
  }

  void scrollTo(num x, num y) {
    _content
        ..x = Math.min(Math.max(_viewport.x, x), 0)
        ..y = Math.min(Math.max(_viewport.y, y), 0);
    _hbar.value = _content.x / _viewport.x * _content.width;
    _vbar.value = _content.y / _viewport.y * _content.height;
  }

  // TODO: Only one child can be add. so need to fix it.
  @override
  void addChild(DisplayObject child) {
//    child.on(Event.RESIZE).listen((e) => _adjustViewport());
    _content.addChild(child);
    _adjustViewport();
  }

  @override
  void addChildAt(DisplayObject child, int index) {
    _content.addChildAt(child, index);
    _adjustViewport();
  }

  void removeChild(DisplayObject child) {
    _content.removeChild(child);
    _adjustViewport();
  }

  void removeChildAt(int index) {
    _content.removeChildAt(index);
    _adjustViewport();
  }

  void removeChildren([int beginIndex = 0, int endIndex = 0x7fffffff]) {
    _content.removeChildren(beginIndex, endIndex);
    _adjustViewport();
  }

  dynamic getChildAt(int index) => _content.getChildAt(index);

  dynamic getChildByName(String name) => _content.getChildByName(name);

  int getChildIndex(DisplayObject child) => _content.getChildIndex(child);

  void setChildIndex(DisplayObject child, int index) {
    _content.setChildIndex(child, index);
  }

  void swapChildren(DisplayObject child1, DisplayObject child2) {
    _content.swapChildren(child1, child2);
  }

  void swapChildrenAt(int index1, int index2) {
    _content.swapChildrenAt(index1, index2);
  }

  void sortChildren(Function compareFunction) {
    _content.sortChildren(compareFunction);
  }

  bool contains(DisplayObject child) => _content.contains(child);

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

  int get numChildren => _content.numChildren;

  int get backgroundColor => _backgroundColor;

  set backgroundColor(int val) {
    _backgroundColor = val;
    invalidate();
  }

  void _adjustViewport() {
    _viewport.setTo(width - _content.width, height - _content.height);
    _hbar
        ..width = width
        ..y = height - _hbar.height
        ..range = width
        ..maximum = _content.width;
    _vbar
        ..height = height
        ..x = width - _vbar.width
        ..range = height
        ..maximum = _content.height;
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
