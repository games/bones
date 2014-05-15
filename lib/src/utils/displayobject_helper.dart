part of bones;



class DisplayObjectHelper {

  static final Rectangle DEFAULT_PLANE_GRID = new Rectangle(2, 2, 5, 5);

  static final TextRenderer defaultTextRenderer = (txt, [TextFormat format]) {
    var l = new TextField()..autoSize = TextFieldAutoSize.LEFT;
    if (format != null) l.defaultTextFormat = format;
    l.text = txt;
    return l;
  };

  static Scale9Bitmap toScale9Bitmap(DisplayObject drawable, Rectangle grid) {
    return new Scale9Bitmap(new BitmapData(drawable.width.toInt(), drawable.height.toInt(), true, 0x00FFFFFF)..draw(drawable), grid);
  }

  static Scale9Bitmap createPlane(int color) {
    return toScale9Bitmap(new Shape()
        ..graphics.rect(0, 0, 10, 10)
        ..graphics.fillColor(color), DEFAULT_PLANE_GRID);
  }
}
