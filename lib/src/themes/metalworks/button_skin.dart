part of bones.themes.metalworks;



class ButtonSkin extends TextureAtlasSkin {

  @override
  apply() {
    (target as Button)
        ..upState = makeSkin("button-up-skin", MetalworksTheme.BUTTON_SCALE9_GRID)
        ..downState = makeSkin("button-down-skin", MetalworksTheme.BUTTON_SCALE9_GRID)
        ..textRenderer = (String msg, [TextFormat format]) {
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
