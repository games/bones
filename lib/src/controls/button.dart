part of bones;




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
  HorizontalAlign _align;
  DisplayObject _label;
  String _text;
  TextRenderer _textRenderer;
  TextFormat _format;

  bool _enabled = true;
  num padding;

  DisplayObject _currentState;
  Matrix _tmpMatrix = new Matrix.fromIdentity();

  Button({textIconRelation: TextImageRelation.IMAGE_BEFORE_TEXT, this.padding: 5, HorizontalAlign align: HorizontalAlign.CENTER, Skin skin: null}): super(skin) {
    useHandCursor = true;
    _registerEvents();
    _textIconRelation = textIconRelation;
    _align = align;
    _textRenderer = _textRenderer == null ? DisplayObjectHelper.defaultTextRenderer : _textRenderer;
  }

  set text(String val) {
    _text = val;
    _label = null;
  }
  String get text => _text;

  set textRenderer(TextRenderer val) {
    _label = null;
    _textRenderer = val;
  }

  set textFormat(TextFormat val) {
    _label = null;
    _format = val;
  }

  set textIconRelation(TextImageRelation val) => _textIconRelation = val;
  set align(HorizontalAlign val) => _align = val;

  @override
  set width(num val) {
    _width = val;
    if (_upState != null) _upState.width = _width;
    if (_downState != null) _downState.width = _width;
    if (_overState != null) _overState.width = _width;
    if (_hitTestState != null) _hitTestState.width = _width;
  }

  @override
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

  get upState => _upState;

  set downState(DisplayObject val) {
    _downState = val;
    _setSizeForState(val);
  }

  get downState => _downState == null ? _upState : _downState;

  set overState(DisplayObject val) {
    _overState = val;
    _setSizeForState(val);
  }

  get overState => _overState == null ? _upState : _overState;

  set hitTestState(DisplayObject val) {
    _hitTestState = val;
    _setSizeForState(val);
  }

  get hitTestState => _hitTestState == null ? _upState : _hitTestState;

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
    if (hitTestState != null) {
      var state = hitTestState;
      Matrix matrix = state.transformationMatrix;
      num deltaX = localX - matrix.tx;
      num deltaY = localY - matrix.ty;
      num childX = (matrix.d * deltaX - matrix.c * deltaY) / matrix.det;
      num childY = (matrix.a * deltaY - matrix.b * deltaX) / matrix.det;
      if (state.hitTestInput(childX, childY) != null) return this;
    }
    return null;
  }

  // TODO: so crazy code. should be refactoring.
  void render(RenderState renderState) {
    if (_dirty) {
      repaint();
      _dirty = false;
    }
    if (_currentState != null) {
      renderState.renderDisplayObject(_currentState);
      if (icon != null) {
        icon.x = (_currentState.width - icon.width) / 2;
        icon.y = (_currentState.height - icon.height) / 2;
      }
      if (_text != null && _label == null && _textRenderer != null) {
        _label = _textRenderer(_text, _format);
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
            _label.y = icon.y + padding + icon.height + 1;
            _alignForVertical();
            break;
          case TextImageRelation.IMAGE_BEFORE_TEXT:
            icon.x = (_currentState.width - w) / 2;
            _label.x = icon.x + padding + icon.width + 1;
            _alignForHorizontal(icon, _label);
            break;
          case TextImageRelation.OVERLAY:
            break;
          case TextImageRelation.TEXT_ABOVE_IMAGE:
            _label.y = (_currentState.height - h) / 2;
            icon.y = _label.y + padding + _label.height + 1;
            _alignForVertical();
            break;
          case TextImageRelation.TEXT_BEFORE_IMAGE:
            _label.x = (_currentState.width - w) / 2;
            icon.x = _label.x + padding + _label.width + 1;
            _alignForHorizontal(_label, icon);
            break;
        }
      }
      if (icon != null) renderState.renderDisplayObject(icon);
      if (_label != null) renderState.renderDisplayObject(_label);
    }
  }

  void _alignForHorizontal(DisplayObject first, DisplayObject second) {
    if (_align == HorizontalAlign.LEFT) {
      first.x = padding;
      second.x = first.x + first.width + padding;
    } else if (_align == HorizontalAlign.RIGHT) {
      second.x = _currentState.width - padding - second.width;
      first.x = second.x - first.width - padding;
    }
  }

  void _alignForVertical() {
    if (_align == HorizontalAlign.LEFT) {
      icon.x = _label.x = padding;
    } else if (_align == HorizontalAlign.RIGHT) {
      icon.x = _currentState.width - icon.width - padding;
      _label.x = _currentState.width - _label.width - padding;
    }
  }

  void _mouseEventHandler(MouseEvent event) {
    if (_enabled == false) return;
    if (event.type == MouseEvent.MOUSE_OUT || event.type == MouseEvent.CLICK) {
      _currentState = upState;
    } else {
      _currentState = event.buttonDown ? downState : overState;
    }
    if (event.type == MouseEvent.CLICK) dispatchEvent(new Event(PRESSED));
  }

  void _touchEventHandler(TouchEvent event) {
    if (_enabled == false) return;
    if (event.type == TouchEvent.TOUCH_OUT || event.type == TouchEvent.TOUCH_END) {
      _currentState = upState;
    } else {
      _currentState = event.type == TouchEvent.TOUCH_BEGIN ? downState : overState;
    }
    if (event.type == TouchEvent.TOUCH_END) dispatchEvent(new Event(PRESSED));
  }

  DisplayObject get currentState => _currentState;
  set currentState(DisplayObject state) => _currentState = state;

  @override
  String get skinName => Theme.BUTTON_SKIN;
}
