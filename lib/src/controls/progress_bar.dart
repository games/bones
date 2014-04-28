part of valorzhong_bones;


class ProgressBar extends Component {
  int minimum = 0;
  int maximum = 100;
  int _value = 0;
  int _width = 100;
  int _height = 2;

  ProgressBar() {
    repaint();
  }

  reset() => _value = minimum;
  step() => value = _value + 1;

  int get value => _value;
  set value(int val) {
    if (val < minimum) val = minimum;
    if (val > maximum) val = maximum;
    _value = val;
    _invalidate = true;
  }

  setSize(int w, int h) {
    _width = w;
    _height = h;
    _invalidate = true;
  }

  repaint() {
    graphics
        ..clear()
        ..beginPath()
        ..rect(0, 0, _width, _height)
        ..fillColor(0x33000000)
        ..beginPath()
        ..rect(0, 0, _width * (_value - minimum) / (maximum - minimum), _height)
        ..fillColor(0xffffcc00);

  }
}
