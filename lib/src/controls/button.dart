part of valorzhong_bones;

typedef DisplayObject TextRenderer(String txt);

const EventStreamProvider<Event> pressedEvent = const EventStreamProvider<Event>(Button.PRESSED);

class Button extends Skinnable {
  static const String PRESSED = "BUTTON_PRESSED";

  EventStream<Event> get onPressed => pressedEvent.forTarget(this);

  DisplayObject _upState;
  DisplayObject _overState;
  DisplayObject _downState;
  DisplayObject _hitTestState;
  DisplayObject icon;

  TextImageRelation _textIconRelation;
  DisplayObject _label;
  String _text;
  TextRenderer _textRenderer;

  bool _enabled = true;
  num _width, _height;

  DisplayObject _currentState;
  Matrix _tmpMatrix = new Matrix.fromIdentity();

  Button({textIconRelation: TextImageRelation.IMAGE_BEFORE_TEXT, Skin skin: null}): super(skin) {
    useHandCursor = true;
    _registerEvents();
    _textIconRelation = textIconRelation;
    _textRenderer = (txt) => new TextField(txt)..autoSize = TextFieldAutoSize.LEFT;
  }

  set text(String val) => _text = val;
  String get text => _text;

  set textRenderer(TextRenderer val) {
    _label = null;
    _textRenderer = val;
  }

  set textIconRelation(TextImageRelation val) => _textIconRelation = val;

  set width(num val) {
    _width = val;
    if (_upState != null) _upState.width = _width;
    if (_downState != null) _downState.width = _width;
    if (_overState != null) _overState.width = _width;
    if (_hitTestState != null) _hitTestState.width = _width;
  }

  set height(num val) {
    _height = val;
    if (_upState != null) _upState.height = _height;
    if (_downState != null) _downState.height = _height;
    if (_overState != null) _overState.height = _height;
    if (_hitTestState != null) _hitTestState.height = _height;
  }

  set upState(DisplayObject val) {
    _upState = val;
    _setSizeForState(val);
    if (_currentState == null) _currentState = val;
  }

  set downState(DisplayObject val) {
    _downState = val;
    _setSizeForState(val);
  }

  set overState(DisplayObject val) {
    _overState = val;
    _setSizeForState(val);
  }

  set hitTestState(DisplayObject val) {
    _hitTestState = val;
    _setSizeForState(val);
  }

  set enabled(bool val) {
    useHandCursor = val;
    _enabled = val;
  }

  get enabled => _enabled;

  _setSizeForState(DisplayObject state) {
    if (state == null) return;
    if (_width != null) state.width = _width;
    if (_height != null) state.height = _height;
  }

  _registerEvents() {
    onMouseOver.listen(_mouseEventHandler);
    onMouseOut.listen(_mouseEventHandler);
    onMouseDown.listen(_mouseEventHandler);
    onMouseUp.listen(_mouseEventHandler);
    onMouseClick.listen(_mouseEventHandler);
    onTouchOver.listen(_touchEventHandler);
    onTouchOut.listen(_touchEventHandler);
    onTouchBegin.listen(_touchEventHandler);
    onTouchEnd.listen(_touchEventHandler);
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
    if (_invalid) {
      repaint();
      _invalid = false;
    }
    if (_currentState != null) {
      renderState.renderDisplayObject(_currentState);
      if (icon != null) {
        icon.x = (_currentState.width - icon.width) / 2;
        icon.y = (_currentState.height - icon.height) / 2;
      }
      if (_text != null && _label == null && _textRenderer != null) {
        _label = _textRenderer(_text);
      }
      if (_label != null) {
        _label.x = (_currentState.width - _label.width) / 2;
        _label.y = (_currentState.height - _label.height) / 2;
      }
      if (icon != null && _label != null) {
        var w = icon.width + _label.width,
            h = icon.height + icon.height;
        switch (_textIconRelation) {
          case TextImageRelation.IMAGE_ABOVE_TEXT:
            icon.y = (_currentState.height - h) / 2;
            _label.y = icon.y + icon.height + 1;
            break;
          case TextImageRelation.IMAGE_BEFORE_TEXT:
            icon.x = (_currentState.width - w) / 2;
            _label.x = icon.x + icon.width + 1;
            break;
          case TextImageRelation.OVERLAY:
            break;
          case TextImageRelation.TEXT_ABOVE_IMAGE:
            _label.y = (_currentState.height - h) / 2;
            icon.y = _label.y + _label.height + 1;
            break;
          case TextImageRelation.TEXT_BEFORE_IMAGE:
            _label.x = (_currentState.width - w) / 2;
            icon.x = _label.x + _label.width + 1;
            break;
        }
      }
      if (icon != null) renderState.renderDisplayObject(icon);
      if (_label != null) renderState.renderDisplayObject(_label);
    }
  }

  void _mouseEventHandler(MouseEvent event) {
    if (_enabled == false) return;
    if (event.type == MouseEvent.MOUSE_OUT || event.type == MouseEvent.CLICK) {
      _currentState = _upState;
    } else {
      _currentState = event.buttonDown ? _downState : _overState;
    }
    if (event.type == MouseEvent.CLICK) dispatchEvent(new Event(PRESSED));
  }

  void _touchEventHandler(TouchEvent event) {
    if (_enabled == false) return;
    if (event.type == TouchEvent.TOUCH_OUT || event.type == TouchEvent.TOUCH_END) {
      _currentState = _upState;
    } else {
      _currentState = event.type == TouchEvent.TOUCH_BEGIN ? _downState : _overState;
    }
    if (event.type == TouchEvent.TOUCH_END) dispatchEvent(new Event(PRESSED));
  }

  @override
  Skin get defaultSkin => new ButtonSkin();
}
