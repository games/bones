part of valorzhong_bones;




class ToastSkin extends Skin {

  final ellipse = 10;

  ToastSkin(): super() {
    width = 200;
    height = 50;
  }

  @override
  apply() {
    var toast = target as Toast;
    if (toast.message != null) {
      toast.background = new Shape()
          ..graphics.rectRound(0, 0, width, height, ellipse, ellipse)
          ..graphics.fillColor(Color.Black);
      toast.content = new TextField()
          ..defaultTextFormat.color = Color.White
          ..text = toast.message
          ..autoSize = TextFieldAutoSize.LEFT;
    }
  }
}
