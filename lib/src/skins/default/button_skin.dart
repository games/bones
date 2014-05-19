part of bones;


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

    var up, over, down, hit, ellipse = 8;
    if (upState == null) {
      up = DisplayObjectHelper.createRound(DefaultTheme.BUTTON_FACE, ellipse, border: false, borderColor: Color.Gray);
      btn.width = 150;
      btn.height = 40;
    } else {
      up = upState;
    }

    if (overState == null) {
      if (upState == null) over = DisplayObjectHelper.createRound(DefaultTheme.BUTTON_DOWN, ellipse, border: false, borderColor: Color.Gray); else over = upState;
    } else {
      over = overState;
    }

    if (downState == null) {
      if (upState == null) down = DisplayObjectHelper.createRound(DefaultTheme.BUTTON_DOWN, ellipse, border: false, borderColor: Color.Gray); else down = upState;
    } else {
      down = downState;
    }

    if (hitTestState == null) hit = up; else hit = hitTestState;
    if (icon != null) btn.icon = icon;

    if (upState == null) {
      btn.width = 150;
      btn.height = 40;
    }
    if (btn.width == 0) btn.width = up.width;
    if (btn.height == 0) btn.height = up.height;

    btn
        ..upState = up
        ..overState = over
        ..downState = down
        ..hitTestState = hit;
  }

  @override
  repaint() {
  }
}
