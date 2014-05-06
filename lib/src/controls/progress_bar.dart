part of valorzhong_bones;


class ProgressBar extends Skinnable {
  int _value = 1;
  int _minimum = 1;
  int _maximum = 100;

  ProgressBar([Skin skin]): super(skin);

  reset() => _value = _minimum;
  step() => value = _value + 1;

  int get value => _value;

  set value(int val) {
    if (val < _minimum) val = _minimum;
    if (val > _maximum) val = _maximum;
    _value = val;
    invalidate();
  }

  get minimum => _minimum;

  set minimum(int val) {
    _minimum = val;
    invalidate();
  }

  get maximum => _maximum;

  set maximum(int val) {
    _maximum = val;
    invalidate();
  }

  get percent => (_value - _minimum) / (_maximum - _minimum);

  @override
  Skin get defaultSkin => new LinearProgressBarSkin();
}
