part of bones;



class Alert extends Skinnable {
  static final List<ButtonDef> BUTTONS_OK = [const ButtonDef(label: "OK", event: Event.OKAY)];
  static final List<ButtonDef> BUTTONS_OK_CANCEL = [const ButtonDef(label: "OK", event: Event.OKAY), const ButtonDef(label: "CANCEL", event: Event.CANCEL)];

  String message, title;
  bool isModal;
  bool cover;
  num bodyWidth, bodyHeight;

  num padding = 20;
  DisplayObject background;
  ButtonGroup buttons;
  DisplayObject header;
  DisplayObject content;

  @override
  repaint() {
    super.repaint();

    var doublePadding = padding * 2;

    removeChildren();
    addChild(background);

    if (bodyWidth != null && bodyHeight != null) {
      _width = bodyWidth + doublePadding;
      _height = bodyHeight + doublePadding;
      content
          ..width = bodyWidth
          ..height = bodyHeight;
    } else if (content != null) {
      _width = content.width + doublePadding;
      _height = content.height + doublePadding;
    } else {
      _width = doublePadding;
      _height = doublePadding;
    }

    var headerHeight = 0;
    if (header != null) {
      header
          ..x = padding
          ..y = padding;
      addChild(header);
      headerHeight = header.height + doublePadding;
      _width = Math.max(header.width + doublePadding, _width);
      _height = _height + header.height + doublePadding;
    }

    if (content != null) {
      content
          ..width = _width - doublePadding
          ..x = padding
          ..y = headerHeight + (_height - headerHeight - content.height) / 2;
      addChild(content);
    }

    if (buttons != null) {
      _width = Math.max(_width, buttons.width + doublePadding);
      _height = _height + doublePadding + buttons.height;
      buttons.x = (_width - buttons.width) / 2;
      buttons.y = _height - buttons.height - doublePadding;
      addChild(buttons);
    }

    background
        ..width = _width.toInt()
        ..height = _height.toInt();
  }


  Alert(this.message, {this.title: null, this.isModal: true, this.cover: true, List<ButtonDef> buttonDefs, this.bodyWidth: null, this.bodyHeight: null, Skin skin: null}): super(skin) {
    if (buttonDefs != null) {
      buttons = new ButtonGroup(buttonDefs);
      buttons.onSelected.listen((e) {
        dispatchEvent(new Event(e.event));
        close();
      });
    }
  }

  close() => dispatchEvent(new Event(Event.CLOSE));

  static Alert make({String message: null, String title: null, List<ButtonDef> buttonsDefs: null, bodyWidth: null, bodyHeight: null, bool isModal: true, bool cover: true, Skin skin: null}) {
    return new Alert(message, title: title, isModal: isModal, cover: cover, buttonDefs: buttonsDefs, skin: skin, bodyWidth: bodyWidth, bodyHeight: bodyHeight);
  }

  static Alert ok(String message, {String title: null, bool isModal: true, bool cover: true, Skin skin: null, bodyWidth: null, bodyHeight: null}) {
    return new Alert(message, title: title, isModal: isModal, cover: cover, buttonDefs: BUTTONS_OK, skin: skin, bodyWidth: bodyWidth, bodyHeight: bodyHeight);
  }

  static Alert okayCancel(String message, {String title: null, bool isModal: true, bool cover: true, Skin skin: null, bodyWidth: null, bodyHeight: null}) {
    return new Alert(message, title: title, isModal: isModal, cover: cover, buttonDefs: BUTTONS_OK_CANCEL, skin: skin, bodyWidth: bodyWidth, bodyHeight: bodyHeight);
  }
}

class PopupManager {

  static Alert message(String message, {String title: null, bool isModal: true, bool cover: true, List<ButtonDef> buttonsDefs: null, Skin skin: null, num bodyWidth: null, num bodyHeight: null}) {
    var alert = Alert.make(message: message, title: title, isModal: isModal, cover: cover, buttonsDefs: buttonsDefs, skin: skin, bodyWidth: bodyWidth, bodyHeight: bodyHeight);
    show(alert);
    return alert;
  }

  static show(Alert alert) {
    Application.instance.push(new _PopupScreen(alert));
  }
}

class _PopupScreen extends Screen {
  Alert alert;
  _PopupScreen(this.alert);

  @override
  enter() {
    if (alert.cover) {
      addChild(renderBackground());
    }
    alert.repaint();
    alert.x = (stage.sourceWidth - alert.width) / 2;
    alert.y = (stage.sourceHeight - alert.height) / 2;
    alert.on(Event.CLOSE).listen((e) => Application.instance.remove(this));
    addChild(alert);
  }

  @override
  exit() {
    removeChild(alert);
  }

  DisplayObject renderBackground() {
    return new Sprite()
        ..graphics.rect(0, 0, stage.sourceWidth, stage.sourceHeight)
        ..graphics.fillColor(ColorHelper.fromRgba(0, 0, 0, 0.2))
        ..applyCache(0, 0, stage.sourceWidth, stage.sourceHeight);
  }
}
