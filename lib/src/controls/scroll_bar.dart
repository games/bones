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
      background.width = width;
      background.height = height;
      addChild(background);
    }
    if (slider != null) {
      addChild(slider);
      if(_range > 0) {
        var sp = _range / (maximum - minimum);
        if (orientation == Orientation.VERTICAL) {
          slider.width = width.toInt();
          slider.height = (height * sp).toInt();
        } else {
          slider.width = (width * sp).toInt();
          slider.height = height.toInt();
        }
        slider.visible = true;
      } else {
        slider.visible = false;
      }
    }
    _adjustSlider();
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

  _adjustSlider() {
    if (background != null && slider != null) {
      if (orientation == Orientation.VERTICAL) {
        slider.x = 0;
        slider.y = percent * (background.height - slider.height);
      } else {
        slider.x = percent * (background.width - slider.width);
        slider.y = 0;
      }
    }
  }
}
