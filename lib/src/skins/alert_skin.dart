part of valorzhong_bones;



class AlertSkin extends Skin {
  num padding, doublePadding;

  AlertSkin(): super() {
    padding = 8;
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

    var messageBounds = new Rectangle(0, 0, message.width + doublePadding, message.height + doublePadding);
    Rectangle titleBounds;
    if (title != null) {
      titleBounds = new Rectangle(0, 0, Math.max(title.width + doublePadding, messageBounds.width), title.height + doublePadding);
      messageBounds.top = titleBounds.top + titleBounds.height;
      messageBounds.width = titleBounds.width;
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
        ..rect(messageBounds.left, messageBounds.top, messageBounds.width, messageBounds.height)
        ..fillColor(Color.White);
    content.graphics
        ..beginPath()
        ..rect(0, 0, content.width, content.height)
        ..strokeColor(Color.Black);
    message
        ..x = messageBounds.left + padding
        ..y = messageBounds.top + padding;
    comp.addChild(message);
  }
}
