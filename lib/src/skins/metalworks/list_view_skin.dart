part of bones.themes.metalworks;




class ListViewSkin extends TextureAtlasSkin {
  ItemRenderer renderer;
  ItemRenderer dividerRenderer;

  ListViewSkin({this.renderer, this.dividerRenderer}): super();

  @override
  apply() {
    var listView = target as ListView;
    listView.itemWidth = listView.itemWidth == null ? 200 : listView.itemWidth;
    listView.itemHeight = listView.itemHeight == null ? 60 : listView.itemHeight;
    listView.itemRenderer = renderer != null ? renderer : (num position, item) {
      var btn = new Button(align: HorizontalAlign.LEFT, padding: 15, skin: new ListViewItemSkin(theme));
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

  @override
  repaint() {
  }
}

class ListViewItemSkin extends TextureAtlasSkin {

  ListViewItemSkin(TextureAtlasTheme theme): super(theme);

  @override
  apply() {
    (target as Button)
        ..upState = scale9Skin("list-item-up-skin", MetalworksTheme.ITEM_RENDERER_SCALE9_GRID)
        ..downState = scale9Skin("list-item-selected-skin", MetalworksTheme.ITEM_RENDERER_SCALE9_GRID)
        ..textRenderer = (String msg) {
          return new TextField()
              ..defaultTextFormat.size = 16
              ..defaultTextFormat.bold = true
              ..defaultTextFormat.align = TextFormatAlign.CENTER
              ..defaultTextFormat.color = Color.White
              ..text = msg
              ..autoSize = TextFieldAutoSize.CENTER;
        }
        ..width = 100
        ..height = 50;
  }
}
