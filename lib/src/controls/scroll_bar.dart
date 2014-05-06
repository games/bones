part of valorzhong_bones;



class ScrollBar extends ProgressBar {
  Orientation _orientation;
  num _range;

  DisplayObject slider;
  DisplayObject background;

  ScrollBar({num range: 0, Orientation orientation: Orientation.VERTICAL, Skin skin: null})
      : _range = range,
        _orientation = orientation,
        super(skin);

  @override
  repaint() {
    super.repaint();
    removeChildren();
    if (background != null) {
      addChild(background);
    }
    if (background != null && slider != null) {
      addChild(slider
          ..x = 0
          ..y = 0);
      if (orientation == Orientation.VERTICAL) {
        slider.y = percent * (background.height - slider.height);
      } else {
        slider.x = percent * (background.width - slider.width);
      }
    }
  }

  Orientation get orientation => _orientation;

  void set orientation(Orientation val) {
    _orientation = val;
    invalidate();
  }

  num get range => _range;

  void set range(num val) {
    _range = val;
    invalidate();
  }

  @override
  set value(int val) {
    if (val < _minimum) val = _minimum;
    if (val > _maximum) val = _maximum;
    _value = val;
    if (background != null && slider != null) {
      if (orientation == Orientation.VERTICAL) {
        slider.y = percent * (background.height - slider.height);
      } else {
        slider.x = percent * (background.width - slider.width);
      }
    }
  }

  @override
  Skin get defaultSkin => new ScrollBarSkin();
}
