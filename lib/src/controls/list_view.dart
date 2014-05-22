part of bones;


typedef DisplayObject ItemRenderer(num position, data);
const EventStreamProvider<Event> itemSelectedEvent = const EventStreamProvider<Event>(ListView.EVENT_ITEM_SELECTED);

class ListView extends Skinnable {
  static const EVENT_ITEM_SELECTED = "EVENT_ITEM_SELECTED";

  EventStream<Event> get onItemSelected => itemSelectedEvent.forTarget(this);

  DisplayObject header;
  DisplayObject footer;
  num itemWidth, itemHeight;
  bool divider;
  ItemRenderer itemRenderer;
  ItemRenderer dividerRenderer;
  List _data;
  int _selectedIndex = -1;
  DisplayObject _selectedItem;

  ListView({List data, Skin skin})
      : _data = data,
        divider = true,
        super(skin) {
    if (data != null) invalidate();
  }

  @override
  measure() {
    super.measure();
    if (_data != null) {
      var hw = 0,
          fw = 0;
      if (header != null) hw = header.width;
      if (footer != null) fw = footer.width;
      _width = Math.max(Math.max(hw, fw), itemWidth);
      _height = _data.length * itemHeight;
    } else {
      _width = 0;
      _height = 0;
    }
  }

  @override
  repaint() {
    super.repaint();
    //refer : https://github.com/bp74/StageXL/issues/106
    //DisplayObjectHelper.removeChildren(this);
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
        _width = header.width;
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
        _width = Math.max(footer.width, _width);
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
  String get skinName => Theme.LIST_VIEW_SKIN;

  int get selectedIndex => _selectedIndex;

  DisplayObject get selectedItem => _selectedItem;

  get selectedData {
    if (_data != null && _selectedIndex >= 0 && _selectedIndex < _data.length) return _data[_selectedIndex];
    return null;
  }
}
