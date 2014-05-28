part of bones;






abstract class Popup extends Component {
  bool get cover;
  EventStream<Event> get onClose;
  HorizontalAlign get hAlign;
  VerticalAlign get vAlign;
}

class PopupManager {

  static Alert message(String message, {String title: null, bool isModal: true, bool cover: true, List<ButtonDef> buttonsDefs: null, Skin skin: null, num bodyWidth: null, num bodyHeight: null}) {
    var alert = Alert.make(message: message, title: title, isModal: isModal, cover: cover, buttonsDefs: buttonsDefs, skin: skin, bodyWidth: bodyWidth, bodyHeight: bodyHeight);
    show(alert);
    return alert;
  }

  static show(Popup alert) {
    Application.instance.push(new _PopupScreen(alert));
  }
}

class _PopupScreen extends Screen {
  Popup _popup;
  _PopupScreen(this._popup);

  @override
  enter() {
    if (_popup.cover) {
      addChild(renderBackground());
    }
    addChild(_popup);
    switch (_popup.hAlign) {
      case HorizontalAlign.LEFT:
        _popup.x = 0;
        break;
      case HorizontalAlign.CENTER:
        _popup.x = (stage.sourceWidth - _popup.width) / 2;
        break;
      case HorizontalAlign.RIGHT:
        _popup.x = stage.sourceWidth - _popup.width;
        break;
    }
    switch (_popup.vAlign) {
      case VerticalAlign.TOP:
        _popup.y = 0;
        break;
      case VerticalAlign.MIDDLE:
        _popup.y = (stage.sourceHeight - _popup.height) / 2;
        break;
      case VerticalAlign.BOTTOM:
        _popup.y = stage.sourceHeight - _popup.height;
        break;
    }
    _popup.onClose.listen((e) => Application.instance.remove(this));
  }

  @override
  exit() {
    _popup.onClose.cancelSubscriptions();
    removeChild(_popup);
  }

  DisplayObject renderBackground() {
    return new Sprite()
        ..graphics.rect(0, 0, stage.sourceWidth, stage.sourceHeight)
        ..graphics.fillColor(ColorHelper.fromRgba(0, 0, 0, 0.4))
        ..applyCache(0, 0, stage.sourceWidth, stage.sourceHeight);
  }
}
