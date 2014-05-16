part of bones;






typedef DisplayObject TextRenderer(String txt, [TextFormat format]);

class Label extends Skinnable {

  Layout _layout;
  String _description;
  String _text;
  HorizontalAlign _hAlign;
  VerticalAlign _vAlign;
  TextRenderer _textRenderer;
  TextRenderer descriptionRenderer;
  TextFormat textFormat;
  TextFormat descriptionFormat;
  int gap = 10;

  DisplayObject background;
  DisplayObject content;

  Label({String text, HorizontalAlign hAlign: HorizontalAlign.CENTER, VerticalAlign vAlign: VerticalAlign.MIDDLE, TextRenderer textRenderer, Skin skin}): super(skin) {
    _text = text;
    _hAlign = hAlign;
    _vAlign = vAlign;
    _textRenderer = textRenderer;
    _layout = new SingleLayout(horizontalAlign: hAlign, verticalAlign: vAlign);
  }

  String get text => _text;

  void set text(String val) {
    _text = val;
    invalidate();
  }

  String get description => _description;

  void set description(String val) {
    _description = val;
    invalidate();
  }

  HorizontalAlign get hAlign => _hAlign;

  void set hAlign(HorizontalAlign val) {
    _hAlign = val;
    invalidate();
  }

  VerticalAlign get vAlign => _vAlign;

  void set vAlign(VerticalAlign val) {
    _vAlign = val;
    invalidate();
  }

  TextRenderer get textRenderer => _textRenderer;

  void set textRenderer(TextRenderer val) {
    _textRenderer = val;
    invalidate();
  }

  @override
  initialize() {
    super.initialize();
    if (textRenderer == null) textRenderer = DisplayObjectHelper.defaultTextRenderer;
    if (descriptionRenderer == null) descriptionRenderer = DisplayObjectHelper.defaultTextRenderer;
    if (background != null) {
      addChild(background);
    }
    content = _makeContent();
    if (content != null) {
      addChild(content);
    }
    if (width == 0) width = content.width + 2 * gap;
    if (height == 0) height = content.height;
    _layout.order(this);
    validate();
  }

  DisplayObject _makeContent() {
    var t, d;
    if (_text != null) {
      t = textRenderer(_text, textFormat);
    }
    if (_description != null) {
      var c = new Sprite();
      d = descriptionRenderer(_description, descriptionFormat);
      c.addChild(d);

      if (t != null) {
        var w = width;
        if (w == 0) {
          t.x = d.x + d.width + gap;
        } else {
          t.x = (width - gap * 2 - t.width);
        }
        c.addChild(t);
      }
      return c;
    } else {
      return t;
    }
  }

  @override
  repaint() {
    super.repaint();
    if (background != null) {
      background.width = _width;
      background.height = _height;
    }
    if (content != null) {
      content.removeFromParent();
    }
    if (_text != null) {
      content = _makeContent();
      if (content != null) {
        addChild(content);
      }
    }
    _layout.order(this);
  }

  @override
  String get skinName => "Label";
}
