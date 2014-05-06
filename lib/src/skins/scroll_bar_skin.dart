part of valorzhong_bones;




class ScrollBarSkin extends Skin {

  ScrollBarSkin(): super() {
    width = 10;
    height = 200;
  }

  @override
  apply() {
    var bar = target as ScrollBar;

    var sw,
        sh,
        sp = bar.range / (bar.maximum - bar.minimum),
        h,
        v;

    if (bar.orientation == Orientation.VERTICAL) {
      h = width;
      v = height;
      sw = h;
      sh = v * sp;
    } else {
      h = height;
      v = width;
      sw = h * sp;
      sh = v;
    }
    bar.slider = new Shape()
        ..graphics.rectRound(0, 0, sw, sh, 5, 5)
        ..graphics.fillColor(Color.WhiteSmoke);

    bar.background = new Shape()
        ..graphics.rectRound(0, 0, h, v, 5, 5)
        ..graphics.fillColor(Color.Gray);
  }
}
