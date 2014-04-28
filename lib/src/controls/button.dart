part of valorzhong_bones;



class Button extends InteractiveObject {

  DisplayObject _upState;
  DisplayObject _overState;
  DisplayObject _downState;
  DisplayObject _hitTestState;

  bool enabled = true;

  DisplayObject _currentState;
  Matrix _tmpMatrix = new Matrix.fromIdentity();

  Button([this._upState, this._overState, this._downState, this._hitTestState]) {
    useHandCursor = true;

    addEventListener(MouseEvent.MOUSE_OVER, _onMouseEvent);
    addEventListener(MouseEvent.MOUSE_OUT, _onMouseEvent);
    addEventListener(MouseEvent.MOUSE_DOWN, _onMouseEvent);
    addEventListener(MouseEvent.MOUSE_UP, _onMouseEvent);

    onTouchOver.listen(_touchEventHandler);
    onTouchOut.listen(_touchEventHandler);
    onTouchBegin.listen(_touchEventHandler);
    onTouchEnd.listen(_touchEventHandler);

    _currentState = this._upState;
  }

  set upState(DisplayObject val) {
    _upState = val;
    if (_currentState == null) {
      _currentState = val;
    }
  }

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
    if (mouseEvent.type == MouseEvent.MOUSE_OUT) {
      _currentState = _upState;
    } else {
      _currentState = mouseEvent.buttonDown ? _downState : _overState;
    }
  }

  void _touchEventHandler(TouchEvent event) {
    print(event.type);
    if (event.type == TouchEvent.TOUCH_OUT || event.type == TouchEvent.TOUCH_END) {
      _currentState = _upState;
    } else {
      _currentState = event.type == TouchEvent.TOUCH_BEGIN ? _downState : _overState;
    }
  }
}





















class Button2 extends Component {
  Button2(String skin, String label): super() {
    mouseEnabled = false;

    var resources = Application.instance.take(ResourceManager) as ResourceManager;
    var grid = new Rectangle(13, 15, 10, 25);
    var ut = new Scale9Texture(resources.getBitmapData(skin + "_off"), grid);
    var dt = new Scale9Texture(resources.getBitmapData(skin + "_on"), grid);
    var ub = new Scale9Bitmap(ut);
    ub.width = 200;
    ub.height = 40;
    var db = new Scale9Bitmap(dt);
    db.width = 200;
    db.height = 40;
    var btn = new SimpleButton(ub, ub, db, ub);
    addChild(btn);

    var txt = new TextField();
    txt.defaultTextFormat = new TextFormat("Helvetica,Arial", 20, Color.White);
    txt.autoSize = TextFieldAutoSize.LEFT;
    txt.text = label;
    txt.x = (btn.width - txt.width) / 2;
    txt.y = (btn.height - txt.height) / 2;
    txt.mouseEnabled = false;
    addChild(txt);
  }
}







