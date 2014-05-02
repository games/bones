part of valorzhong_bones;




class ButtonSkin extends Skin {

  DisplayObject upState;
  DisplayObject overState;
  DisplayObject downState;
  DisplayObject hitTestState;
  DisplayObject icon;
  num width, height;

  ButtonSkin({this.upState, this.overState, this.downState, this.hitTestState, this.icon, this.width: 100, this.height: 50});

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
