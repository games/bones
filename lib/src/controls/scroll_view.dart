part of valorzhong_bones;




class ScrollView extends Container {

  Component _content;
  Point _lastPos;
  int _backgroundColor = Color.White;
  ScrollBar _hbar, _vbar;
  Point<num> _viewport;

  ScrollView(): super() {
    _hbar = new ScrollBar(orientation: Orientation.HORIZONTAL)..visible = false;
    super.addChildAt(_hbar, 0);
    _vbar = new ScrollBar(orientation: Orientation.VERTICAL)..visible = false;
    super.addChildAt(_vbar, 0);
    _content = new Component();
    super.addChildAt(_content, 0);
    _viewport = new Point(0, 0);

    _lastPos = new Point(0, 0);
    on(Event.RESIZE).listen(_resizeHandler);
    onMouseDown.listen((e) {
      if (stage != null) {
        _stopScrolling();
        _showScrollBars();
        _lastPos.setTo(e.stageX, e.stageY);
        stage.onMouseMove.listen(_stageMouseMoveHandler);
        stage.onMouseUp.listen(_stageMouseUpHandler);
      }
    });
  }

  void _stopScrolling() {
    _hbar.visible = false;
    _vbar.visible = false;
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
    mask = new Mask.rectangle(_bounds.left, _bounds.top, _bounds.width, _bounds.height);
    _adjustViewport();
    scrollTo(_content.x, _content.y);
  }

  void scrollTo(num x, num y) {
    _content
        ..x = Math.min(Math.max(_viewport.x, x), _bounds.left)
        ..y = Math.min(Math.max(_viewport.y, y), _bounds.top);
    _hbar.value = _content.x / _viewport.x * _content.width;
    _vbar.value = _content.y / _viewport.y * _content.height;
  }

  @override
  void addChild(DisplayObject child) {
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
          ..rect(_bounds.left, _bounds.top, _bounds.width, _bounds.height)
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
    _viewport.setTo(_bounds.right - _content.width, _bounds.bottom - _content.height);
    _hbar
        ..skin.width = _bounds.width
        ..y = _bounds.bottom - _hbar.height
        ..range = _bounds.width
        ..maximum = _content.width;
    _vbar
        ..skin.height = _bounds.height
        ..x = _bounds.right - _vbar.width
        ..range = _bounds.height
        ..maximum = _content.height;
  }

  _showScrollBars() {
    _hbar.visible = visibleHBar;
    _vbar.visible = visibleVBar;
  }

  bool get visibleHBar => _content.width > _bounds.width;
  bool get visibleVBar => _content.height > _bounds.height;
}
