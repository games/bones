part of valorzhong_bones;


class ScrollBarSkin extends Skin {
  static const num WIDTH = 5;
  static const num HEIGHT = 200;

  @override
  apply() {
    var bar = target as ScrollBar;
    if (bar.orientation == Orientation.VERTICAL) {
      bar.width = bar.width == 0 ? WIDTH : bar.width;
      bar.height = bar.height == 0 ? HEIGHT : bar.height;
    } else {
      bar.width = bar.width == 0 ? HEIGHT : bar.width;
      bar.height = bar.height == 0 ? WIDTH : bar.height;
    }

    bar.background = createScale9Bitmap(new Shape()
      ..graphics.beginPath()
      ..graphics.rect(0, 0, 10, 10)
      ..graphics.fillColor(0x33000000), new Rectangle(2, 2, 5, 5));

    bar.slider = createScale9Bitmap(new Shape()
      ..graphics.beginPath()
      ..graphics.rect(0, 0, 10, 10)
      ..graphics.fillColor(Color.WhiteSmoke), new Rectangle(2, 2, 5, 5));
  }

  @override
  repaint() {
  }
}