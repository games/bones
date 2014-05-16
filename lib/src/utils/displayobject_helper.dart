part of bones;



class DisplayObjectHelper {

  static final Rectangle DEFAULT_PLANE_GRID = new Rectangle(2, 2, 5, 5);
  static final Rectangle DEFAULT_RECTROUND_GRID = new Rectangle(6, 6, 5, 5);

  static final TextRenderer defaultTextRenderer = (txt, [TextFormat format]) {
    var l = new TextField();
    if (format != null) l.defaultTextFormat = format;
    return l
        ..text = txt
        ..autoSize = TextFieldAutoSize.LEFT;
  };

  static Scale9Bitmap toScale9Bitmap(DisplayObject drawable, Rectangle grid) {
    return new Scale9Bitmap(new BitmapData(drawable.width.toInt(), drawable.height.toInt(), true, 0x00FFFFFF)..draw(drawable), grid);
  }

  static Scale9Bitmap createPlane(int color, {bool border: false, int borderColor: 0, int borderSize: 0}) {
    var shape = new Shape()
        ..graphics.rect(0, 0, 10, 10)
        ..graphics.fillColor(color);
    if (border) {
      shape..graphics.strokeColor(borderColor, borderSize);
    }
    return toScale9Bitmap(shape, DEFAULT_PLANE_GRID);
  }

  static Scale9Bitmap createRound(int color, num ellipse, {bool border: false, int borderColor: 0, int borderSize: 1}) {
    var shape = new Shape()
        ..graphics.rectRound(0, 0, 20, 20, ellipse, ellipse)
        ..graphics.fillColor(color);
    if (border) {
      shape.graphics.strokeColor(borderColor, borderSize);
    }
    return toScale9Bitmap(shape, DEFAULT_RECTROUND_GRID);
  }
}
