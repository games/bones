part of valorzhong_bones;




class Toast extends Skinnable {

  String _message;
  num delay = 2;

  DisplayObject background;
  DisplayObject content;

  DelayedCall _delayedCall;

  Toast([Skin skin]): super(skin);

  @override
  repaint() {
    super.repaint();
    removeChildren();
    if (background != null) {
      addChild(background
          ..x = 0
          ..y = 0);
    }
    if (content != null) {
      addChild(content
          ..x = (background.width - content.width) / 2
          ..y = (background.height - content.height) / 2);
    }
    if (background != null || content != null) {
      var juggler = Application.instance.stage.juggler;
      if (_delayedCall != null) {
        juggler.remove(_delayedCall);
      }
      _delayedCall = juggler.delayCall(() {
        visible = false;
        _delayedCall = null;
      }, delay);
    }
  }

  show(String val) {
    _message = val;
    visible = true;
    removeChildren();
    invalidate();
  }

  String get message => _message;
}
