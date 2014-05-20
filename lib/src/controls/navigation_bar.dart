part of bones;




class NavigationBar extends Skinnable {

  List<DisplayObject> _left;
  List<DisplayObject> _right;
  String _title;
  TextRenderer textRenderer;
  DisplayObject _background;
  int gap;

  NavigationBar({this.gap: 0, Skin skin})
      : _left = [],
        _right = [],
        super(skin);

  set title(String val) {
    _title = val;
    invalidate();
  }

  DisplayObject get background => _background;

  void set background(DisplayObject val) {
    if (_background != null) _background.removeFromParent();
    _background = val;
    addChild(_background);
  }

  addLeft(DisplayObject item) {
    _left.add(item);
    invalidate();
  }

  addRight(DisplayObject item) {
    _right.add(item);
    invalidate();
  }

  @override
  initialize() {
    super.initialize();
    addChild(_background);
  }

  @override
  repaint() {
    super.repaint();
    removeChildren();

    addChild(_background);
    var nx = gap;
    _left.forEach((item) {
      item.x = nx;
      item.y = (height - item.height) / 2;
      nx += item.width + gap;
      addChild(item);
    });
    nx = width - gap;
    _right.forEach((item) {
      item.x = nx - item.width;
      item.y = (height - item.height) / 2;
      nx = item.x - gap;
      addChild(item);
    });
    if (_title != null) {
      var title = textRenderer(_title);
      title.x = (width - title.width) / 2;
      title.y = (height - title.height) / 2;
      addChild(title);
    }
  }

  @override
  String get skinName => Theme.NAVIGATION_BAR_SKIN;
}
