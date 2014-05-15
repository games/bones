part of bones;




class NavigationBarSkin extends Skin {

  @override
  apply() {
    var bar = target as NavigationBar;
    bar.textRenderer = (txt, [TextFormat format]) => new TextField()
        ..defaultTextFormat.color = Color.White
        ..defaultTextFormat.size = 18
        ..defaultTextFormat.bold = true
        ..text = txt
        ..autoSize = TextFieldAutoSize.LEFT;
    bar.background = DisplayObjectHelper.createPlane(0xFF313131);
    if (bar.stage != null) {
      bar.background.width = bar.stage.sourceWidth;
      bar.background.height = 45;
    }
  }
}
