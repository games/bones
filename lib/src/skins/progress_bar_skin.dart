part of valorzhong_bones;




class LinearProgressBarSkin extends Skin {

  apply() {
    var bar = target as ProgressBar;
    if (bar.width == 0) bar.width = 100;
    if (bar.height == 0) bar.height = 2;
  }

  @override
  repaint() {
    var bar = target as ProgressBar;
    bar.graphics
        ..clear()
        ..beginPath()
        ..rect(0, 0, bar.width, bar.height)
        ..fillColor(0x33000000)
        ..beginPath()
        ..rect(0, 0, bar.width * bar.percent, bar.height)
        ..fillColor(0xffffcc00);
  }
}

class CountdownSkin extends Skin {
  int _size;
  int _border;
  TextField _label;
  num _halfSize;

  CountdownSkin([this._size = 120, this._border = 10]) {
    _halfSize = _size / 2;
  }

  @override
  apply() {

  }

  @override
  repaint() {
    var bar = target as ProgressBar;
    bar.removeChildren();
    bar.graphics
        ..clear()
        ..beginPath()
        ..arc(_halfSize, _halfSize, _halfSize, 0, TWO_PI, false)
        ..fillColor(ColorHelper.fromRgba(0, 0, 0, 0.7))
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
    bar.measure();
    _label.text = bar.value.toString();
    _label.x = (bar.width - _label.width) / 2;
    _label.y = (bar.height - _label.height) / 2;
    bar.addChild(_label);
  }
}
