part of bones.themes.metalworks;




// assets from http://feathersui.com/
class MetalworksTheme extends TextureAtlasTheme {
  static final DEFAULT_SCALE9_GRID = new Rectangle(5, 5, 22, 22);
  static final BUTTON_SCALE9_GRID = new Rectangle(5, 5, 50, 50);
  static final BUTTON_SELECTED_SCALE9_GRID = new Rectangle(8, 8, 44, 44);
  static final BACK_BUTTON_SCALE3_REGION1 = 24;
  static final BACK_BUTTON_SCALE3_REGION2 = 6;
  static final FORWARD_BUTTON_SCALE3_REGION1 = 6;
  static final FORWARD_BUTTON_SCALE3_REGION2 = 6;
  static final ITEM_RENDERER_SCALE9_GRID = new Rectangle(13, 0, 2, 82);
  static final INSET_ITEM_RENDERER_FIRST_SCALE9_GRID = new Rectangle(13, 13, 3, 70);
  static final INSET_ITEM_RENDERER_LAST_SCALE9_GRID = new Rectangle(13, 0, 3, 75);
  static final INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID = new Rectangle(13, 13, 3, 62);
  static final TAB_SCALE9_GRID = new Rectangle(19, 19, 50, 50);

  static final SCROLL_BAR_HORIZONTAL = new Rectangle(10, 5, 5, 1);
  static final SCROLL_BAR_VERTICAL = new Rectangle(5, 10, 1, 5);

  MetalworksTheme(ResourceManager resources, String altas): super(resources, altas) {
    register(Theme.ALERT_SKIN, new AlertSkin());
    register(Theme.BUTTON_SKIN, new ButtonSkin());
    register(Theme.LIST_VIEW_SKIN, new ListViewSkin());
    register(Theme.PROGRESS_BAR_SKIN, new ProgressBarSkin());
    register(Theme.SCROLL_BAR_SKIN, new ScrollBarSkin());
    register(Theme.TOAST_SKIN, new ToastSkin());
  }
}
