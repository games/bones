part of bones.themes.metalworks;




class ProgressBarSkin extends TextureAtlasSkin {

  Bitmap background;
  Bitmap progress;

  apply() {
    var bar = target as ProgressBar;
    if (bar.width == 0) bar.width = 240;
    if (bar.height == 0) bar.height = 22;

    background = scale9Skin("background-skin", MetalworksTheme.DEFAULT_SCALE9_GRID);
    background.width = bar.width;
    background.height = bar.height;
    bar.addChild(background);

    progress = scale9Skin("button-up-skin", MetalworksTheme.BUTTON_SCALE9_GRID);
    progress.width = bar.width;
    progress.height = bar.height;
    bar.addChild(progress);
  }

  @override
  repaint() {
    var bar = target as ProgressBar;
    background.width = bar.width;
    progress.width = (bar.width * bar.percent).toInt() + 5;
    progress.visible = progress.width > 0;
  }
}
