part of bones;


typedef DisplayObject ItemRenderer(num position, data);
const EventStreamProvider<Event> itemSelectedEvent = const EventStreamProvider<Event>(ListView.EVENT_ITEM_SELECTED);

class ListView extends Skinnable {
  static const EVENT_ITEM_SELECTED = "EVENT_ITEM_SELECTED";

  EventStream<Event> get onItemSelected => itemSelectedEvent.forTarget(this);

  DisplayObject header;
  DisplayObject footer;
  num itemWidth, itemHeight;
  ItemRenderer itemRenderer;
  ItemRenderer dividerRenderer;
  List _data;
  int _selectedIndex = -1;
  DisplayObject _selectedItem;

  ListView([List data, Skin skin])
      : _data = data,
        super(skin);

  @override
  repaint() {
    super.repaint();
    removeChildren();
    if (_data != null && itemRenderer != null) {
      _width = 0;
      _height = 0;
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
        if (item is InteractiveObject) {
          _itemHandler(item, i);
        }
        bottom += item.height;
        addChild(item);
        _width = Math.max(item.width, _width);
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
        _height = bottom + footer.height;
      } else {
        _height = bottom;
      }
      _fireResize();
    }
  }

  _itemHandler(item, int i) {
    var handler = (e) {
      _selectedIndex = i;
      _selectedItem = item;
      dispatchEvent(new Event(EVENT_ITEM_SELECTED));
    };
    if (Multitouch.inputMode == MultitouchInputMode.TOUCH_POINT) {
      item.onTouchEnd.listen(handler);
    } else {
      item.onMouseClick.listen(handler);
    }
  }

  List get data => _data;

  void set data(val) {
    _data = val;
    invalidate();
  }

  @override
  String get skinName => "ListView";

  int get selectedIndex => _selectedIndex;

  DisplayObject get selectedItem => _selectedItem;

  get selectedData {
    if (_data != null && _selectedIndex >= 0 && _selectedIndex < _data.length) return _data[_selectedIndex];
    return null;
  }
}
