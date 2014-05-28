part of bones;



class Alert extends Skinnable implements Popup {
  static final List<ButtonDef> BUTTONS_OK = [const ButtonDef(label: "OK", event: Event.OKAY)];
  static final List<ButtonDef> BUTTONS_OK_CANCEL = [const ButtonDef(label: "OK", event: Event.OKAY), const ButtonDef(label: "CANCEL", event: Event.CANCEL)];

  String message, title;
  bool isModal;
  bool cover;
  num bodyWidth, bodyHeight;

  num padding = 10;
  DisplayObject background;
  ButtonGroup buttons;
  DisplayObject header;
  DisplayObject content;

  @override
  initialize() {
    super.initialize();
    var dp = padding * 2;
    removeChildren();
    addChild(background);

    if (bodyWidth != null && bodyHeight != null) {
      _width = bodyWidth + dp;
      _height = bodyHeight + dp;
      if (content != null) content
          ..width = bodyWidth
          ..height = bodyHeight;
    } else if (content != null) {
      _width = content.width + dp;
      _height = content.height + dp;
    } else {
      _width = dp;
      _height = dp;
    }

    var headerHeight = 0;
    if (header != null) {
      addChild(header..y = padding);
      headerHeight = header.height + dp;
      _width = Math.max(header.width + dp, _width);
      _height = _height + header.height + dp;
    }

    if (content != null) {
      addChild(content
          ..width = _width - dp
          ..y = headerHeight + (_height - headerHeight - content.height) / 2);
    }

    if (buttons != null) {
      _width = Math.max(_width, buttons.width + dp);
      _height = _height + dp + buttons.height;
      buttons.x = (_width - buttons.width) / 2;
      buttons.y = _height - buttons.height - padding;
      addChild(buttons);
    }

    if (header != null) header.x = (_width - header.width) / 2;
    if (content != null) content.x = (_width - content.width) / 2;

    background
        ..width = _width.toInt()
        ..height = _height.toInt();
  }


  Alert(this.message, {this.title: null, this.isModal: true, this.cover: true, List<ButtonDef> buttonDefs, this.bodyWidth: null, this.bodyHeight: null, Skin skin: null}) : super(skin) {
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

  @override
  String get skinName => Theme.ALERT_SKIN;

  @override
  EventStream<Event> get onClose => closeEvent.forTarget(this);

  @override
  HorizontalAlign get hAlign => HorizontalAlign.CENTER;

  @override
  VerticalAlign get vAlign => VerticalAlign.MIDDLE;
}

