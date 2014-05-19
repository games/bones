part of bones;


class ListViewSkin extends Skin {
  ItemRenderer renderer;
  ItemRenderer dividerRenderer;
  int itemUpColor;
  int itemOverColor;
  int itemDownColor;
  int dividerColor;

  ListViewSkin({this.renderer, this.dividerRenderer, this.itemUpColor: DefaultTheme.LIST_DEFAULT, this.itemOverColor: DefaultTheme.LIST_ROLLOVER, this.itemDownColor:
      DefaultTheme.LIST_SELECTED, this.dividerColor: DefaultTheme.LIST_DIVIDER}): super();

  @override
  apply() {
    var listView = target as ListView;
    listView.itemWidth = listView.itemWidth == null ? 200 : listView.itemWidth;
    listView.itemHeight = listView.itemHeight == null ? 50 : listView.itemHeight;
    listView.itemRenderer = renderer != null ? renderer : (num position, item) {
      var btn = new Button(align: HorizontalAlign.LEFT, padding: 10, skin: new ListViewItemSkin(itemUpColor, itemOverColor, itemDownColor));
      btn.width = listView.itemWidth;
      btn.height = listView.itemHeight;
      if (item is Map) {
        if (item.containsKey("icon")) {
          btn.icon = item["icon"];
        }
        if (item.containsKey("label")) {
          btn.text = item["label"];
        }
        if (item.containsKey("height")) {
          btn.height = item["height"];
        }
      } else {
        btn.text = item.toString();
      }
      return btn;
    };
    if (listView.divider) {
      listView.dividerRenderer = dividerRenderer != null ? dividerRenderer : (num position, item) {
        return new Shape()
            ..graphics.rect(0, 0, listView.itemWidth, 1)
            ..graphics.fillColor(dividerColor)
            ..applyCache(0, 0, listView.itemWidth, 1);
      };
    }
  }

  @override
  repaint() {
  }
}

class ListViewItemSkin extends Skin {
  int upColor;
  int overColor;
  int downColor;

  ListViewItemSkin(this.upColor, this.overColor, this.downColor);

  @override
  apply() {
    var btn = target as Button;
    if (btn.width == 0) btn.width = 200;
    if (btn.height == 0) btn.height = 50;

    var grid = new Rectangle(10, 10, btn.width - 20, btn.height - 20);

    var upState = DisplayObjectHelper.createPlane(upColor)
        ..width = btn.width
        ..height = btn.height;

    var overState = DisplayObjectHelper.createPlane(overColor)
        ..width = btn.width
        ..height = btn.height;

    var downState = DisplayObjectHelper.createPlane(downColor)
        ..width = btn.width
        ..height = btn.height;

    btn
        ..upState = upState
        ..overState = overState
        ..downState = downState
        ..hitTestState = upState;
  }
}
