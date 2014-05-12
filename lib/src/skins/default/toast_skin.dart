part of bones;


class ToastSkin extends Skin {
  final ellipse = 5;
  final padding = 20;

  @override
  apply() {
    var toast = target as Toast;
    if (toast.width == 0) toast.width = 200;
    if (toast.height == 0) toast.height = 50;

    toast.background = createScale9Bitmap(new Shape()
      ..graphics.rectRound(0, 0, toast.width, toast.height, ellipse, ellipse)
      ..graphics.fillColor(Color.Black), new Rectangle(5, 5, 10, 10));

    toast.background = createScale9Bitmap(new Shape()
      ..graphics.beginPath()
      ..graphics.rectRound(0, 0, 30, 30, ellipse, ellipse)
      ..graphics.fillColor(Color.Black), new Rectangle(ellipse, ellipse, 5, 5));

    toast.content = new TextField()
      ..defaultTextFormat.color = Color.White
      ..autoSize = TextFieldAutoSize.LEFT;
  }

  @override
  repaint() {
    var toast = target as Toast;
    if (toast.message != null) {
      toast.content.text = toast.message;
      toast.background.width = toast.content.width + padding;
      toast.background.height = toast.content.height + padding;
      toast.width = toast.background.width;
      toast.height = toast.background.height;
    }
  }
}
