part of valorzhong_bones;




class ListViewSkin extends Skin {

  ItemRenderer renderer;

  ListViewSkin({this.renderer, num width, num height}): super() {
    this.width = width;
    this.height = height;
  }

  @override
  apply() {
    var listView = target as ListView;
    listView.itemWidth = width == null ? 200 : width;
    listView.itemHeight = height == null ? 50 : height;
    listView.itemRenderer = renderer != null ? renderer : (num position, item) {
      var btn = new Button(align: HorizontalAlign.LEFT, padding: 10, skin: new ListViewItemSkin(width: listView.itemWidth, height: listView.itemHeight));
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

  ListViewItemSkin({num width: 200, num height: 50})
      : super() {
    this.width = width;
    this.height = height;
  }

  @override
  apply() {
    var upState = new Shape()
        ..graphics.beginPath()
        ..graphics.rect(0, 0, width, height)
        ..graphics.fillColor(Color.White)
        ..graphics.strokeColor(Color.Gray);
    var overState = new Shape()
        ..graphics.beginPath()
        ..graphics.rect(0, 0, width, height)
        ..graphics.fillColor(Color.WhiteSmoke)
        ..graphics.strokeColor(Color.Gray);
    var downState = new Shape()
        ..graphics.beginPath()
        ..graphics.rect(0, 0, width, height)
        ..graphics.fillColor(Color.WhiteSmoke)
        ..graphics.strokeColor(Color.Gray, 2);
    var hitTestState = upState;
    (target as Button)
        ..upState = upState
        ..overState = overState
        ..downState = downState
        ..hitTestState = upState;
  }
}
