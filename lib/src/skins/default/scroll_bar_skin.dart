part of bones;


class ScrollBarSkin extends Skin {
  static const num WIDTH = 2;
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
    bar.background = DisplayObjectHelper.createPlane(0x03000000);
    bar.slider = DisplayObjectHelper.createPlane(0xF0000000);
  }

  @override
  repaint() {
  }
}
