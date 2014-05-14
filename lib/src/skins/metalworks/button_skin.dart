part of bones.themes.metalworks;



class ButtonSkin extends TextureAtlasSkin {

  @override
  apply() {
    (target as Button)
        ..upState = scale9Skin("button-up-skin", MetalworksTheme.BUTTON_SCALE9_GRID)
        ..downState = scale9Skin("button-down-skin", MetalworksTheme.BUTTON_SCALE9_GRID)
        ..textRenderer = (String msg) {
          return new TextField()
              ..defaultTextFormat.size = 16
              ..defaultTextFormat.bold = true
              ..defaultTextFormat.align = TextFormatAlign.CENTER
              ..defaultTextFormat.color = Color.Black
              ..text = msg
              ..autoSize = TextFieldAutoSize.CENTER;
        }
        ..width = 100
        ..height = 50;
  }
}