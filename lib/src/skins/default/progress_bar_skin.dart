part of bones;


class LinearProgressBarSkin extends Skin {

  Bitmap background;
  Bitmap progress;

  apply() {
    var bar = target as ProgressBar;
    if (bar.width == 0) bar.width = 200;
    if (bar.height == 0) bar.height = 2;

    background = createScale9Bitmap(new Shape()
        ..graphics.beginPath()
        ..graphics.rect(0, 0, 2, 2)
        ..graphics.fillColor(0x33000000), new Rectangle(1, 1, 1, 1))
        ..width = bar.width
        ..height = bar.height;
    bar.addChild(background);

    progress = createScale9Bitmap(new Shape()
        ..graphics.beginPath()
        ..graphics.rect(0, 0, 2, 2)
        ..graphics.fillColor(0xffffcc00), new Rectangle(1, 1, 1, 1));
    bar.addChild(progress);
  }

  @override
  repaint() {
    var bar = target as ProgressBar;
    background.width = bar.width;
    progress.width = (bar.width * bar.percent).toInt();
  }
}

class CountdownSkin extends Skin {
  int _size;
  int _border;
  TextField _label;
  num _halfSize;

  Shape _background;

  CountdownSkin([this._size = 120, this._border = 10]) {
    _halfSize = _size / 2;
  }

  @override
  apply() {
    var bar = target as ProgressBar;
    _background = new Shape();
    _background.graphics
        ..clear()
        ..beginPath()
        ..arc(_halfSize, _halfSize, _halfSize, 0, TWO_PI, false)
        ..fillColor(ColorHelper.fromRgba(0, 0, 0, 0.7))
        ..beginPath()
        ..arc(_halfSize, _halfSize, _halfSize - _border, 0, TWO_PI, false)
        ..strokeColor(0xff999999, _border);
    _background.applyCache(0, 0, _background.width.toInt(), _background.height.toInt());
    bar.addChild(_background);

    _label = new TextField()
        ..defaultTextFormat.bold = true
        ..defaultTextFormat.color = Color.White
        ..defaultTextFormat.size = 50
        ..autoSize = TextFieldAutoSize.CENTER
        ..text = "-";
    bar.addChild(_label);
    bar.measure();
  }

  _getProgress(num percent) {
    var s = new Shape()
        ..graphics.arc(_halfSize, _halfSize, _halfSize - _border, -Math.PI / 2, TWO_PI * percent - Math.PI / 2, false)
        ..graphics.strokeColor(0xffffcc00, _border);
    s.applyCache(0, 0, _size, _size);
    return s;
  }

  @override
  repaint() {
    var bar = target as ProgressBar;
    bar.removeChildren();
    bar.addChild(_background);
    bar.addChild(_getProgress(bar.percent));
    _label.text = bar.value.toString();
    _label.x = (bar.width - _label.width) / 2;
    _label.y = (bar.height - _label.height) / 2;
    bar.addChild(_label);
  }
}
