part of valorzhong_bones;



class Alert extends Skinnable {

  String message, title;
  bool isModal;
  bool cover;

  Alert(this.message, {this.title: null, this.isModal: true, this.cover: true}): super();

  @override
  Renderer get defaultRenderer => new AlertRenderer();
}

class PopupManager {

  static message(String message, {String title: null, bool isModal: true, bool cover: true}) {
    show(new Alert(message, title: title, isModal: isModal, cover: cover));
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
    alert.x = (Application.instance.stage.sourceWidth - alert.width) / 2;
    alert.y = (Application.instance.stage.sourceHeight - alert.height) / 2;
    addChild(alert);
  }

  @override
  exit() {
    removeChild(alert);
  }

  DisplayObject renderBackground() {
    return new Sprite()
        ..graphics.rect(0, 0, Application.instance.stage.sourceWidth, Application.instance.stage.sourceHeight)
        ..graphics.fillColor(ColorHelper.fromRgba(0, 0, 0, 0.5));
  }
}
