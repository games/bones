part of bones;


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
    bar.background = DisplayObjectHelper.createPlane(DefaultTheme.SCROLL_BAR_BACKGROUND);
    bar.slider = DisplayObjectHelper.createRound(DefaultTheme.SCROLL_BAR_SLIDER, 2);
  }
}
