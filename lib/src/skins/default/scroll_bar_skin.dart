part of valorzhong_bones;




class ScrollBarSkin extends Skin {
  static const num WIDTH = 5;
  static const num HEIGHT = 200;
  static const num ROUND = 3;

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
  }

  @override
  repaint() {
    var bar = target as ScrollBar;
    var sw,
        sh,
        sp = bar.range / (bar.maximum - bar.minimum);
    if (bar.orientation == Orientation.VERTICAL) {
      sw = bar.width;
      sh = bar.height * sp;
    } else {
      sw = bar.width * sp;
      sh = bar.height;
    }
    if (bar.range > 0) {
      bar.slider = new Shape()
          ..graphics.rectRound(0, 0, sw, sh, ROUND, ROUND)
          ..graphics.fillColor(Color.WhiteSmoke);
    }
    bar.background = new Shape()
        ..alpha = 0.5
        ..graphics.rectRound(0, 0, bar.width, bar.height, ROUND, ROUND)
        ..graphics.fillColor(Color.Gray);
  }
}
