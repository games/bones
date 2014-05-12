part of bones;


class AlertSkin extends Skin {
  num padding, doublePadding;

  AlertSkin({this.padding: 8}): super() {
    doublePadding = padding * 2;
  }

  @override
  apply() {

  }

  @override
  repaint() {
    var alert = target as Alert;
    alert.removeChildren();

    var background = new Shape();
    alert.addChild(background);

    TextField message;
    if (alert.message != null) {
      message = new TextField()
        ..defaultTextFormat.size = 12
        ..defaultTextFormat.align = TextFormatAlign.CENTER
        ..autoSize = TextFieldAutoSize.CENTER
        ..text = alert.message;
    }
    Rectangle bodyBounds;
    if (alert.bodyWidth != null && alert.bodyHeight != null) {
      bodyBounds = new Rectangle(0, 0, alert.bodyWidth + doublePadding, alert.bodyHeight + doublePadding);
      message
        ..multiline = true
        ..wordWrap = true
        ..width = alert.bodyWidth
        ..height = alert.bodyHeight;
    } else if (message != null) {
      bodyBounds = new Rectangle(0, 0, message.width + doublePadding, message.height + doublePadding);
    } else {
      bodyBounds = new Rectangle(0, 0, doublePadding, doublePadding);
    }

    TextField title;
    if (alert.title != null) {
      title = new TextField()
        ..defaultTextFormat.size = 12
        ..defaultTextFormat.bold = true
        ..autoSize = TextFieldAutoSize.CENTER
        ..text = alert.title;
    }

    ButtonGroup buttons;
    if (alert.buttonDefs != null) {
      buttons = new ButtonGroup(alert.buttonDefs);
      bodyBounds.width = Math.max(bodyBounds.width, buttons.width + doublePadding);
      buttons.x = (bodyBounds.width - buttons.width) / 2;
      buttons.y = bodyBounds.bottom + padding;
      buttons.onSelected.listen((e) {
        alert.dispatchEvent(new Event(e.event));
        alert.close();
      });
      bodyBounds.height = bodyBounds.height + doublePadding + buttons.height;
    }

    Rectangle titleBounds;
    if (title != null) {
      titleBounds = new Rectangle(0, 0, Math.max(title.width + doublePadding, bodyBounds.width), title.height + doublePadding);
      bodyBounds.top = titleBounds.top + titleBounds.height;
      bodyBounds.width = titleBounds.width;
    }

    if (message != null) {
      message
        ..width = bodyBounds.width - doublePadding
        ..x = bodyBounds.left + padding
        ..y = bodyBounds.top + (bodyBounds.height - (buttons != null ? buttons.height : 0) - message.height) / 2;
    }

    if (buttons != null) {
      buttons.x = (bodyBounds.width - buttons.width) / 2;
      buttons.y = bodyBounds.bottom - buttons.height - padding;
    }

    background.graphics.clear();
    if (titleBounds != null) {
      background.graphics
        ..beginPath()
        ..rect(titleBounds.left, titleBounds.top, titleBounds.width, titleBounds.height)
        ..fillColor(ColorHelper.fromRgba(222, 222, 222));
      title
        ..x = titleBounds.left + padding
        ..y = titleBounds.top + padding;
      alert.addChild(title);
    }
    background.graphics
      ..beginPath()
      ..rect(bodyBounds.left, bodyBounds.top, bodyBounds.width, bodyBounds.height)
      ..fillColor(Color.White);
    background.graphics
      ..beginPath()
      ..rect(0, 0, background.width, background.height)
      ..strokeColor(Color.Black);

    if (message != null) {
      alert.addChild(message);
    }
    if (buttons != null) alert.addChild(buttons);
    alert.measure();

    background.applyCache(0, 0, background.width.toInt(), background.height.toInt());
  }
}
