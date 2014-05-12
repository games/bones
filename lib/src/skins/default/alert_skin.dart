part of bones;


class AlertSkin extends Skin {

  @override
  apply() {
    var alert = target as Alert;
    if (alert.title != null) {
      alert.header = new TextField()
          ..defaultTextFormat.size = 12
          ..defaultTextFormat.bold = true
          ..autoSize = TextFieldAutoSize.CENTER
          ..text = alert.title;
    }
    if (alert.message != null) {
      alert.content = new TextField()
          ..defaultTextFormat.size = 12
          ..defaultTextFormat.align = TextFormatAlign.CENTER
          ..multiline = true
          ..wordWrap = true
          ..autoSize = TextFieldAutoSize.CENTER
          ..text = alert.message;
    }
    alert.background = createScale9Bitmap(new Shape()
        ..graphics.rectRound(0, 0, 20, 20, 5, 5)
        ..graphics.fillColor(Color.White), new Rectangle(5, 5, 5, 5));
  }

  @override
  repaint() {
  }
}
