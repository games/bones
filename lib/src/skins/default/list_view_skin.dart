part of valorzhong_bones;




class ListViewSkin extends Skin {
  ItemRenderer renderer;
  ListViewSkin({this.renderer}): super();

  @override
  apply() {
    var listView = target as ListView;
    listView.itemWidth = listView.itemWidth == null ? 200 : listView.itemWidth;
    listView.itemHeight = listView.itemHeight == null ? 50 : listView.itemHeight;
  }

  @override
  repaint() {
    var listView = target as ListView;
    listView.itemRenderer = renderer != null ? renderer : (num position, item) {
      var btn = new Button(align: HorizontalAlign.LEFT, padding: 10, skin: new ListViewItemSkin());
      btn.width = listView.itemWidth;
      btn.height = listView.itemHeight;
      if (item is Map) {
        if (item.containsKey("icon")) {
          btn.icon = item["icon"];
        }
        if (item.containsKey("label")) {
          btn.text = item["label"];
        }
      } else {
        btn.text = item.toString();
      }
      return btn;
    };
  }
}

class ListViewItemSkin extends Skin {

  @override
  apply() {
    var btn = target as Button;
    if (btn.width == 0) btn.width = 200;
    if (btn.height == 0) btn.height = 50;
  }

  @override
  repaint() {
    var btn = target as Button;
    var upState = new Shape()
        ..graphics.beginPath()
        ..graphics.rect(0, 0, btn.width, btn.height)
        ..graphics.fillColor(Color.White)
        ..graphics.strokeColor(Color.Gray);
    var overState = new Shape()
        ..graphics.beginPath()
        ..graphics.rect(0, 0, btn.width, btn.height)
        ..graphics.fillColor(Color.WhiteSmoke)
        ..graphics.strokeColor(Color.Gray);
    var downState = new Shape()
        ..graphics.beginPath()
        ..graphics.rect(0, 0, btn.width, btn.height)
        ..graphics.fillColor(Color.WhiteSmoke)
        ..graphics.strokeColor(Color.Gray, 2);
    var hitTestState = upState;
    btn
        ..upState = upState
        ..overState = overState
        ..downState = downState
        ..hitTestState = upState;
  }
}
