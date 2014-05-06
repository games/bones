part of valorzhong_bones;


class ProgressBar extends Skinnable {
  num _value = 1;
  num _minimum = 1;
  num _maximum = 100;

  ProgressBar([Skin skin]): super(skin);

  reset() => _value = _minimum;
  step() => value = _value + 1;

  num get value => _value;

  set value(num val) {
    if (val < _minimum) val = _minimum;
    if (val > _maximum) val = _maximum;
    _value = val;
    invalidate();
  }

  get minimum => _minimum;

  set minimum(num val) {
    _minimum = val;
    invalidate();
  }

  get maximum => _maximum;

  set maximum(num val) {
    _maximum = val;
    invalidate();
  }

  get percent => (_value - _minimum) / (_maximum - _minimum);

  @override
  Skin get defaultSkin => new LinearProgressBarSkin();
}
