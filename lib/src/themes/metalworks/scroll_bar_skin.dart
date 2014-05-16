part of bones.themes.metalworks;




class ScrollBarSkin extends TextureAtlasSkin {
  static const num WIDTH = 10;
  static const num HEIGHT = 200;

  @override
  apply() {
    var bar = target as ScrollBar;
    var sliderSkin;
    if (bar.orientation == Orientation.VERTICAL) {
      bar.width = bar.width == 0 ? WIDTH : bar.width;
      bar.height = bar.height == 0 ? HEIGHT : bar.height;
      bar.slider = makeSkin("vertical-scroll-bar-thumb-skin", MetalworksTheme.SCROLL_BAR_HORIZONTAL);
    } else {
      bar.width = bar.width == 0 ? HEIGHT : bar.width;
      bar.height = bar.height == 0 ? WIDTH : bar.height;
      bar.slider = makeSkin("horizontal-scroll-bar-thumb-skin", MetalworksTheme.SCROLL_BAR_HORIZONTAL);
    }

    bar.background = DisplayObjectHelper.toScale9Bitmap(new Shape()
        ..graphics.beginPath()
        ..graphics.rectRound(0, 0, 10, 10, 5, 5)
        ..graphics.fillColor(0x33000000), new Rectangle(2, 2, 5, 5));
  }
}
