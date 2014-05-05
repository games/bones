part of valorzhong_bones;



class Alert extends Skinnable {
  static final List<ButtonDef> BUTTONS_OK = [const ButtonDef(label: "OK", event: Event.OKAY)];
  static final List<ButtonDef> BUTTONS_OK_CANCEL = [const ButtonDef(label: "OK", event: Event.OKAY), const ButtonDef(label: "CANCEL", event: Event.CANCEL)];

  String message, title;
  bool isModal;
  bool cover;
  List<ButtonDef> buttonDefs;

  Alert(this.message, {this.title: null, this.isModal: true, this.cover: true, this.buttonDefs, Skin skin: null}): super(skin);

  close() => dispatchEvent(new Event(Event.CLOSE));

  static Alert make({String message: null, String title: null, List<ButtonDef> buttonsDefs: null, bool isModal: true, bool cover: true, Skin skin: null}) {
    return new Alert(message, title: title, isModal: isModal, cover: cover, buttonDefs: buttonsDefs, skin: skin);
  }

  static Alert ok(String message, {String title: null, bool isModal: true, bool cover: true, Skin skin: null}) {
    return new Alert(message, title: title, isModal: isModal, cover: cover, buttonDefs: BUTTONS_OK, skin: skin);
  }

  static Alert okayCancel(String message, {String title: null, bool isModal: true, bool cover: true, Skin skin: null}) {
    return new Alert(message, title: title, isModal: isModal, cover: cover, buttonDefs: BUTTONS_OK_CANCEL, skin: skin);
  }

  @override
  Skin get defaultSkin => new AlertSkin();
}

class PopupManager {

  static Alert message(String message, {String title: null, bool isModal: true, bool cover: true, List<ButtonDef> buttonsDefs: null, Skin skin: null}) {
    var alert = Alert.make(message: message, title: title, isModal: isModal, cover: cover, buttonsDefs: buttonsDefs, skin: skin);
    show(alert);
    return alert;
  }

  static show(Alert alert) {
    Application.instance.push(new PopupScreen(alert));
  }
}

class PopupScreen extends Screen {
  Alert alert;
  PopupScreen(this.alert);

  @override
  enter() {
    if (alert.cover) {
      addChild(renderBackground());
    }
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
        ..graphics.fillColor(ColorHelper.fromRgba(0, 0, 0, 0.5));
  }
}
