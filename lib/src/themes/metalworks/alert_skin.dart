part of bones.themes.metalworks;

class AlertSkin extends TextureAtlasSkin {

  @override
  apply() {
    var alert = target as Alert;
    if (alert.title != null) {
      alert.header = new TextField()
          ..defaultTextFormat.size = 20
          ..defaultTextFormat.bold = true
          ..defaultTextFormat.color = Color.White
          ..autoSize = TextFieldAutoSize.CENTER
          ..text = alert.title;
    }
    if (alert.message != null) {
      alert.content = new TextField()
          ..defaultTextFormat.size = 16
          ..defaultTextFormat.bold = true
          ..defaultTextFormat.align = TextFormatAlign.CENTER
          ..defaultTextFormat.color = Color.White
          ..autoSize = TextFieldAutoSize.CENTER
          ..text = alert.message;
    }
    alert.background = makeSkin("background-popup-skin", MetalworksTheme.DEFAULT_SCALE9_GRID);
  }
}
