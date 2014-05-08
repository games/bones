part of valorzhong_bones;




class ButtonSkin extends Skin {

  DisplayObject upState;
  DisplayObject overState;
  DisplayObject downState;
  DisplayObject hitTestState;
  DisplayObject icon;

  ButtonSkin({this.upState, this.overState, this.downState, this.hitTestState, this.icon})
      : super();

  @override
  apply() {
    // TODO: implement apply
  }

  @override
  repaint() {
    var btn = target as Button;
    if (upState == null) {
      upState = new Shape()
          ..graphics.beginPath()
          ..graphics.rectRound(0, 0, btn.width, btn.height, 10, 10)
          ..graphics.fillColor(Color.White)
          ..graphics.strokeColor(Color.Gray);
    }
    if (overState == null) {
      overState = new Shape()
          ..graphics.beginPath()
          ..graphics.rectRound(0, 0, btn.width, btn.height, 10, 10)
          ..graphics.fillColor(Color.WhiteSmoke)
          ..graphics.strokeColor(Color.Gray);
    }
    if (downState == null) {
      downState = new Shape()
          ..graphics.beginPath()
          ..graphics.rectRound(0, 0, btn.width, btn.height, 10, 10)
          ..graphics.fillColor(Color.WhiteSmoke)
          ..graphics.strokeColor(Color.Gray, 2);
    }
    if (hitTestState == null) hitTestState = upState;

    btn
        ..upState = upState
        ..overState = overState
        ..downState = downState
        ..hitTestState = upState
        ..icon = icon;
  }
}
