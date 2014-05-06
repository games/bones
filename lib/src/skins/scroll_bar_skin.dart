part of valorzhong_bones;




class ScrollBarSkin extends Skin {
  static const num WIDTH = 5;
  static const num HEIGHT = 200;
  static const num ROUND = 3;


  @override
  apply() {
    var bar = target as ScrollBar;

    var sw,
        sh,
        sp = bar.range / (bar.maximum - bar.minimum),
        h,
        v;

    if (bar.orientation == Orientation.VERTICAL) {
      h = width == null ? WIDTH : width;
      v = height == null ? HEIGHT : height;
      sw = h;
      sh = v * sp;
    } else {
      h = width == null ? HEIGHT : width;
      v = height == null ? WIDTH : height;
      sw = h * sp;
      sh = v;
    }
    bar.slider = new Shape()
        ..graphics.rectRound(0, 0, sw, sh, ROUND, ROUND)
        ..graphics.fillColor(Color.WhiteSmoke);

    bar.background = new Shape()
        ..alpha = 0.5
        ..graphics.rectRound(0, 0, h, v, ROUND, ROUND)
        ..graphics.fillColor(Color.Gray);
  }
}
