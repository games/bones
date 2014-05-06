part of valorzhong_bones;




class ScrollView extends Container {

  Component _content;
  Point _lastPos;
  int _backgroundColor = Color.White;

  ScrollView(): super() {
    _content = new Component();
    super.addChildAt(_content, 0);
    _lastPos = new Point(0, 0);
    on(Event.RESIZE).listen(_resizeHandler);
    onMouseDown.listen((e) {
      if (stage != null) {
        _clearStageEvents();
        _lastPos.setTo(e.stageX, e.stageY);
        stage.onMouseMove.listen(_stageMouseMoveHandler);
        stage.onMouseUp.listen(_stageMouseUpHandler);
      }
    });
  }

  void _clearStageEvents() {
    stage.removeEventListener(MouseEvent.MOUSE_MOVE, _stageMouseMoveHandler);
    stage.removeEventListener(MouseEvent.MOUSE_UP, _stageMouseUpHandler);
  }

  void _stageMouseMoveHandler(MouseEvent e) {
    var delta = new Point(e.stageX, e.stageY) - _lastPos;
    scrollTo(_content.x + delta.x, _content.y + delta.y);
    _lastPos.setTo(e.stageX, e.stageY);
  }

  void _stageMouseUpHandler(e) {
    _clearStageEvents();
  }

  void _resizeHandler(Event event) {
    mask = new Mask.rectangle(_bounds.left, _bounds.top, _bounds.width, _bounds.height);
  }

  void scrollTo(num x, num y) {
    _content
        ..x = Math.min(Math.max(_bounds.right - _content.width, x), _bounds.left)
        ..y = Math.min(Math.max(_bounds.bottom - _content.height, y), _bounds.top);
  }

  @override
  void addChild(DisplayObject child) {
    _content.addChild(child);
  }

  @override
  void addChildAt(DisplayObject child, int index) {
    _content.addChildAt(child, index);
  }

  void removeChild(DisplayObject child) {
    _content.removeChild(child);
  }

  void removeChildAt(int index) {
    _content.removeChildAt(index);
  }

  void removeChildren([int beginIndex = 0, int endIndex = 0x7fffffff]) {
    _content.removeChildren(beginIndex, endIndex);
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
}
