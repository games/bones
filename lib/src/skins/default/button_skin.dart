part of valorzhong_bones;


class ButtonSkin extends Skin {

  DisplayObject upState;
  DisplayObject overState;
  DisplayObject downState;
  DisplayObject hitTestState;
  DisplayObject icon;

  ButtonSkin({this.upState, this.overState, this.downState, this.hitTestState, this.icon}): super();

  @override
  apply() {
    var btn = target as Button;
    btn.width = 150;
    btn.height = 40;

    var grid = new Rectangle(10, 10, btn.width - 20, btn.height - 20);
    if (upState == null) {
      upState = new Scale9Bitmap(new BitmapData(btn.width, btn.height, true, 0x00FFFFFF)
        ..draw(new Shape()
        ..graphics.beginPath()
        ..graphics.rectRound(0, 0, btn.width, btn.height, 5, 5)
        ..graphics.fillColor(Color.White)), grid);
    }

    if (overState == null) {
      overState = new Scale9Bitmap(new BitmapData(btn.width, btn.height, true, 0x00FFFFFF)
        ..draw(new Shape()
        ..graphics.beginPath()
        ..graphics.rectRound(0, 0, btn.width, btn.height, 5, 5)
        ..graphics.fillColor(Color.WhiteSmoke)), grid);
    }

    if (downState == null) {
      downState = new Scale9Bitmap(new BitmapData(btn.width, btn.height, true, 0x00FFFFFF)
        ..draw(new Shape()
        ..graphics.beginPath()
        ..graphics.rectRound(0, 0, btn.width, btn.height, 10, 10)
        ..graphics.fillColor(Color.WhiteSmoke)), grid);
    }

    if (hitTestState == null) hitTestState = upState;

    btn
      ..upState = upState
      ..overState = overState
      ..downState = downState
      ..hitTestState = upState
      ..icon = icon;
  }

  @override
  repaint() {
  }
}
