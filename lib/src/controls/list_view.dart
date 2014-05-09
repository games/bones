part of valorzhong_bones;


typedef DisplayObject ItemRenderer(num position, data);

class ListView extends Skinnable {
  DisplayObject header;
  DisplayObject footer;
  num itemWidth, itemHeight;
  ItemRenderer itemRenderer;
  ItemRenderer dividerRenderer;
  List _data;

  ListView([List data, Skin skin])
      : _data = data,
        super(skin);

  List get data => _data;

  void set data(val) {
    _data = val;
    invalidate();
  }

  @override
  repaint() {
    super.repaint();
    removeChildren();
    if (_data != null && itemRenderer != null) {
      var num = _data.length,
          bottom = 0;
      if (header != null) {
        addChild(header
            ..x = 0
            ..y = 0);
        bottom = header.height;
      }
      for (var i = 0; i < num; i++) {
        var item = itemRenderer(i, _data[i])
            ..x = 0
            ..y = bottom;
        bottom += item.height;
        addChild(item);
        if (dividerRenderer != null) {
          var divider = dividerRenderer(i, _data[i])
              ..x = 0
              ..y = bottom;
          bottom += divider.height;
          addChild(divider);
        }
      }
      if (footer != null) {
        addChild(footer
            ..x = 0
            ..y = bottom);
      }
    }
  }
}
