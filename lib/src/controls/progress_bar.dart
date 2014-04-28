part of valorzhong_bones;


class ProgressBar extends Component {
  int _value = 1;
  int _minimum = 1;
  int _maximum = 100;
  ProgressBarRenderer _renderer;

  ProgressBar([this._renderer]) {
    if (_renderer == null) {
      _renderer = new LinearProgressBarRenderer();
    }
    repaint();
  }

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
  repaint() {
    _renderer.render(this);
  }
}

abstract class ProgressBarRenderer {
  render(ProgressBar bar);
}

class LinearProgressBarRenderer implements ProgressBarRenderer {
  int _width;
  int _height;
  LinearProgressBarRenderer([this._width = 100, this._height = 2]);

  @override
  render(ProgressBar bar) {
    bar.graphics
        ..clear()
        ..beginPath()
        ..rect(0, 0, _width, _height)
        ..fillColor(0x33000000)
        ..beginPath()
        ..rect(0, 0, _width * bar.percent, _height)
        ..fillColor(0xffffcc00);
  }
}

class CountdownRenderer implements ProgressBarRenderer {
  int _size;
  int _border;
  TextField _label;
  num _halfSize;

  CountdownRenderer([this._size = 120, this._border = 10]) {
    _halfSize = _size / 2;
  }

  @override
  render(ProgressBar bar) {
    bar.graphics
        ..clear()
        ..beginPath()
        ..arc(_halfSize, _halfSize, _halfSize, 0, TWO_PI, false)
        ..fillColor(ColorHelper.fromRgba(0, 0, 0, 0.5))
        ..beginPath()
        ..arc(_halfSize, _halfSize, _halfSize - _border, 0, TWO_PI, false)
        ..strokeColor(0xff999999, _border)
        ..beginPath()
        ..arc(_halfSize, _halfSize, _halfSize - _border, -Math.PI / 2, TWO_PI * bar.percent - Math.PI / 2, false)
        ..strokeColor(0xffffcc00, _border);
    if (_label == null) {
      _label = new TextField()
          ..defaultTextFormat.bold = true
          ..defaultTextFormat.color = Color.White
          ..defaultTextFormat.size = 50
          ..autoSize = TextFieldAutoSize.CENTER
          ..text = "-";
    }
    _label.text = bar.value.toString();
    _label.x = (bar.width - _label.width) / 2;
    _label.y = (bar.height - _label.height) / 2;
    bar.addChild(_label);
  }
}
