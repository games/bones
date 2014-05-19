part of bones;




class SwitchSkin extends Skin {

  @override
  apply() {
    var ellipse = 17;
    var s = target as Switch;
    var w = 55,
        h = 30,
        gap = 1;
    var r = (h - gap * 2) / 2;

    var off = new Shape();
    off.graphics
        ..beginPath()
        ..rectRound(0, 0, w, h, ellipse, ellipse)
        ..fillColor(DefaultTheme.BACKGROUND)
        ..beginPath()
        ..circle(w - r - gap, r + gap, r)
        ..fillColor(DefaultTheme.BUTTON_FACE);
    off.applyCache(0, 0, w, h);
    s.offState = off;

    var on = new Shape();
    on.graphics
        ..beginPath()
        ..rectRound(0, 0, w, h, ellipse, ellipse)
        ..fillColor(DefaultTheme.HIGHLIGHT)
        ..beginPath()
        ..circle(r + gap, r + gap, r)
        ..fillColor(DefaultTheme.BUTTON_FACE);
    on.applyCache(0, 0, w, h);
    s.onState = on;
  }
}
