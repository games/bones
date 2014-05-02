part of valorzhong_bones;



class AlertSkin extends Skin {
  num padding, doublePadding, bodyWidth, bodyHeight;

  AlertSkin({this.padding: 8, this.bodyWidth: 0, this.bodyHeight: 0}): super() {
    doublePadding = padding * 2;
  }

  @override
  apply() {
    var comp = target as Alert;
    comp.removeChildren();

    var content = new Shape();
    comp.addChild(content);

    var message = new TextField()
        ..defaultTextFormat.size = 12
        ..autoSize = TextFieldAutoSize.CENTER
        ..text = comp.message;

    TextField title;
    if (comp.title != null) {
      title = new TextField()
          ..defaultTextFormat.size = 12
          ..defaultTextFormat.bold = true
          ..autoSize = TextFieldAutoSize.CENTER
          ..text = comp.title;
    }

    var bodyBounds = new Rectangle(0, 0, Math.max(message.width, bodyWidth) + doublePadding, Math.max(message.height, bodyHeight) +
        doublePadding);

    ButtonGroup buttons;
    if (comp.buttonDefs != null) {
      buttons = new ButtonGroup(comp.buttonDefs);
      bodyBounds.width = Math.max(bodyBounds.width, buttons.width + doublePadding);
      buttons.x = (bodyBounds.width - buttons.width) / 2;
      buttons.y = bodyBounds.bottom + padding;
      buttons.onSelected.listen((e) => comp.close());
      bodyBounds.height = bodyBounds.height + doublePadding + buttons.height;
    }

    Rectangle titleBounds;
    if (title != null) {
      titleBounds = new Rectangle(0, 0, Math.max(title.width + doublePadding, bodyBounds.width), title.height + doublePadding);
      bodyBounds.top = titleBounds.top + titleBounds.height;
      bodyBounds.width = titleBounds.width;
      buttons.x = (bodyBounds.width - buttons.width) / 2;
      buttons.y = bodyBounds.bottom - buttons.height - padding;
    }

    content.graphics.clear();
    if (titleBounds != null) {
      content.graphics
          ..beginPath()
          ..rect(titleBounds.left, titleBounds.top, titleBounds.width, titleBounds.height)
          ..fillColor(ColorHelper.fromRgba(222, 222, 222));
      title
          ..x = titleBounds.left + padding
          ..y = titleBounds.top + padding;
      comp.addChild(title);
    }
    content.graphics
        ..beginPath()
        ..rect(bodyBounds.left, bodyBounds.top, bodyBounds.width, bodyBounds.height)
        ..fillColor(Color.White);
    content.graphics
        ..beginPath()
        ..rect(0, 0, content.width, content.height)
        ..strokeColor(Color.Black);
    message
        ..x = bodyBounds.left + padding
        ..y = bodyBounds.top + padding;
    comp.addChild(message);
    if (buttons != null) comp.addChild(buttons);
  }
}
