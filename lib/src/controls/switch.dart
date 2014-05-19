part of bones;




class Switch extends Skinnable {

  DisplayObject offState;
  DisplayObject onState;
  bool _isOff = true;

  Matrix _tmpMatrix = new Matrix.fromIdentity();

  Switch([Skin skin]): super(skin);

  @override
  initialize() {
    super.initialize();
    useHandCursor = true;
    if (Multitouch.inputMode == MultitouchInputMode.TOUCH_POINT) {
      onTouchEnd.listen(_pressedHandler);
    } else {
      onMouseClick.listen(_pressedHandler);
    }
  }

  Rectangle<num> getBoundsTransformed(Matrix matrix, [Rectangle<num> returnRectangle]) {
    var s = currentState;
    if (s != null) {
      _tmpMatrix.copyFromAndConcat(s.transformationMatrix, matrix);
      return s.getBoundsTransformed(_tmpMatrix, returnRectangle);
    }
    return super.getBoundsTransformed(matrix, returnRectangle);
  }

  DisplayObject hitTestInput(num localX, num localY) {
    var state = currentState;
    if (state != null) {
      Matrix matrix = state.transformationMatrix;
      num deltaX = localX - matrix.tx;
      num deltaY = localY - matrix.ty;
      num childX = (matrix.d * deltaX - matrix.c * deltaY) / matrix.det;
      num childY = (matrix.a * deltaY - matrix.b * deltaX) / matrix.det;
      if (state.hitTestInput(childX, childY) != null) return this;
    }
    return null;
  }

  void render(RenderState renderState) {
    var state = currentState;
    if (state != null) {
      renderState.renderDisplayObject(state);
    }
  }

  DisplayObject get currentState {
    if (_isOff) return offState; else return onState;
  }


  @override
  String get skinName => Theme.SWITCH_SKIN;

  void _pressedHandler(e) {
    _isOff = !_isOff;
  }
}
