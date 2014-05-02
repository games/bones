part of valorzhong_bones;



class Alert extends Skinnable {

  String message, title;
  bool isModal;
  bool cover;
  List<ButtonDef> buttonDefs;

  Alert(this.message, {this.title: null, this.isModal: true, this.cover: true, this.buttonDefs, Skin skin: null}): super(skin);

  close() => dispatchEvent(new Event(Event.CLOSE));

  static Alert ok(String message, {String title: null, bool isModal: true, bool cover: true}) {
    return new Alert(message, title: title, isModal: isModal, cover: cover, buttonDefs: [new ButtonDef(label: "OK", event: Event.OKAY)]
        );
  }

  static Alert okayCancel(String message, {String title: null, bool isModal: true, bool cover: true}) {
    return new Alert(message, title: title, isModal: isModal, cover: cover, buttonDefs: [new ButtonDef(label: "OK", event: Event.OKAY),
        new ButtonDef(label: "CANCEL", event: Event.CANCEL)]);
  }

  @override
  Skin get defaultSkin => new AlertSkin();
}

class PopupManager {

  static message(String message, {String title: null, bool isModal: true, bool cover: true}) {
    show(Alert.ok(message, title: title, isModal: isModal, cover: cover));
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
