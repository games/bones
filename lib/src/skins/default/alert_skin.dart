part of bones;


class AlertSkin extends Skin {

  @override
  apply() {
    var alert = target as Alert;
    if (alert.title != null) {
      alert.header = new TextField()
          ..defaultTextFormat.size = 18
          ..defaultTextFormat.bold = true
          ..autoSize = TextFieldAutoSize.CENTER
          ..text = alert.title;
    }
    if (alert.message != null) {
      alert.content = new TextField()
          ..defaultTextFormat.size = 14
          ..defaultTextFormat.align = TextFormatAlign.CENTER
          ..multiline = true
          ..autoSize = TextFieldAutoSize.CENTER
          ..text = alert.message;
    }
    alert.background = DisplayObjectHelper.toScale9Bitmap(new Shape()
        ..graphics.rectRound(0, 0, 20, 20, 5, 5)
        ..graphics.fillColor(Color.White), new Rectangle(5, 5, 5, 5));
  }
}
