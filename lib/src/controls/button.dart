part of valorzhong_bones;



class Button extends InteractiveObject {

  DisplayObject _upState;
  DisplayObject _overState;
  DisplayObject _downState;
  DisplayObject _hitTestState;

  bool _enabled = true;

  DisplayObject _currentState;
  Matrix _tmpMatrix = new Matrix.fromIdentity();

  Button([this._upState, this._overState, this._downState, this._hitTestState]) {
    useHandCursor = true;
    _registerEvents();
    _currentState = this._upState;
  }

  set upState(DisplayObject val) {
    _upState = val;
    if (_currentState == null) {
      _currentState = val;
    }
  }
  set overState(DisplayObject val) => _overState = val;
  set downState(DisplayObject val) => _downState = val;
  set hitTestState(DisplayObject val) => _hitTestState = val;

  set enabled(bool val) {
    useHandCursor = val;
    _enabled = val;
  }

  get enabled => _enabled;

  _registerEvents() {
    onMouseOver.listen(_onMouseEvent);
    onMouseOut.listen(_onMouseEvent);
    onMouseDown.listen(_onMouseEvent);
    onMouseUp.listen(_onMouseEvent);
    onTouchOver.listen(_touchEventHandler);
    onTouchOut.listen(_touchEventHandler);
    onTouchBegin.listen(_touchEventHandler);
    onTouchEnd.listen(_touchEventHandler);
  }

  //  unregisterEvents() {
  //    removeEventListener(MouseEvent.MOUSE_OVER, _onMouseEvent);
  //    removeEventListener(MouseEvent.MOUSE_OUT, _onMouseEvent);
  //    removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseEvent);
  //    removeEventListener(MouseEvent.MOUSE_UP, _onMouseEvent);
  //    onTouchOver.cancelSubscriptions();
  //    onTouchOut.cancelSubscriptions();
  //    onTouchBegin.cancelSubscriptions();
  //    onTouchEnd.cancelSubscriptions();
  //  }

  Rectangle<num> getBoundsTransformed(Matrix matrix, [Rectangle<num> returnRectangle]) {
    if (_currentState != null) {
      _tmpMatrix.copyFromAndConcat(_currentState.transformationMatrix, matrix);
      return _currentState.getBoundsTransformed(_tmpMatrix, returnRectangle);
    }
    return super.getBoundsTransformed(matrix, returnRectangle);
  }

  DisplayObject hitTestInput(num localX, num localY) {
    if (this._hitTestState != null) {
      Matrix matrix = this._hitTestState.transformationMatrix;
      num deltaX = localX - matrix.tx;
      num deltaY = localY - matrix.ty;
      num childX = (matrix.d * deltaX - matrix.c * deltaY) / matrix.det;
      num childY = (matrix.a * deltaY - matrix.b * deltaX) / matrix.det;
      if (this._hitTestState.hitTestInput(childX, childY) != null) return this;
    }
    return null;
  }

  void render(RenderState renderState) {
    if (_currentState != null) renderState.renderDisplayObject(_currentState);
  }

  void _onMouseEvent(MouseEvent mouseEvent) {
    if (_enabled == false) return;
    if (mouseEvent.type == MouseEvent.MOUSE_OUT) {
      _currentState = _upState;
    } else {
      _currentState = mouseEvent.buttonDown ? _downState : _overState;
    }
  }

  void _touchEventHandler(TouchEvent event) {
    if (_enabled == false) return;
    if (event.type == TouchEvent.TOUCH_OUT || event.type == TouchEvent.TOUCH_END) {
      _currentState = _upState;
    } else {
      _currentState = event.type == TouchEvent.TOUCH_BEGIN ? _downState : _overState;
    }
  }
}
