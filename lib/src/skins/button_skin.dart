part of valorzhong_bones;




class ButtonSkin extends Skin {

  DisplayObject upState;
  DisplayObject overState;
  DisplayObject downState;
  DisplayObject hitTestState;
  DisplayObject icon;

  ButtonSkin({this.upState, this.overState, this.downState, this.hitTestState, this.icon, num width: 100, num height: 50})
      : super() {
    this.width = width;
    this.height = height;
  }

  @override
  apply() {
    if (upState == null) {
      upState = new Shape()
          ..graphics.beginPath()
          ..graphics.rectRound(0, 0, width, height, 10, 10)
          ..graphics.fillColor(Color.White)
          ..graphics.strokeColor(Color.Gray);
    }
    if (overState == null) {
      overState = new Shape()
          ..graphics.beginPath()
          ..graphics.rectRound(0, 0, width, height, 10, 10)
          ..graphics.fillColor(Color.WhiteSmoke)
          ..graphics.strokeColor(Color.Gray);
    }
    if (downState == null) {
      downState = new Shape()
          ..graphics.beginPath()
          ..graphics.rectRound(0, 0, width, height, 10, 10)
          ..graphics.fillColor(Color.WhiteSmoke)
          ..graphics.strokeColor(Color.Gray, 2);
    }
    if (hitTestState == null) hitTestState = upState;

    (target as Button)
        ..upState = upState
        ..overState = overState
        ..downState = downState
        ..hitTestState = upState
        ..icon = icon;
    //        ..width = width
    //        ..height = height;
  }
}
