part of valorzhong_bones;




class ScrollView extends Container {

  Component _content;

  ScrollView(): super() {
    _content = new Component();
    super.addChildAt(_content, 0);
    on(Event.RESIZE).listen(_resizeHandler);
    onMouseDown.listen((e) {
      if (stage != null) {
        stage.onMouseMove.listen(_stageMouseMoveHandler);

        _content.startDrag(false, _bounds);
        stage.onMouseUp.listen(_onStageMouseUp);
      }
    });
  }

  void _stageMouseMoveHandler(MouseEvent e) {
  }

  void _onStageMouseUp(e) {
    print("stage onmouseup");
    stage.removeEventListener(MouseEvent.MOUSE_UP, _onStageMouseUp);
    _content.stopDrag();
  }

  void _resizeHandler(Event event) {
    //    mask = new Mask.rectangle(_bounds.left, _bounds.top, _bounds.width, _bounds.height);
  }

  void scrollTo(num x, num y) {
    _content
        ..x = x
        ..y = y;
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

  int get numChildren => _content.numChildren;
}
