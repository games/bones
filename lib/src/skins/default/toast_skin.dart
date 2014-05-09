part of valorzhong_bones;




class ToastSkin extends Skin {
  final ellipse = 10;

  @override
  apply() {
    var toast = target as Toast;
    if (toast.width == 0) toast.width = 200;
    if (toast.height == 0) toast.height = 50;
  }

  @override
  repaint() {
    var toast = target as Toast;
    if (toast.message != null) {
      toast.background = new Shape()
          ..graphics.rectRound(0, 0, toast.width, toast.height, ellipse, ellipse)
          ..graphics.fillColor(Color.Black);
      toast.content = new TextField()
          ..defaultTextFormat.color = Color.White
          ..text = toast.message
          ..autoSize = TextFieldAutoSize.LEFT;
    }
  }
}
