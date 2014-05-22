part of bones;



// TODO: Should be cache all bitmapData, instead of create new one every time.
class DefaultTheme extends Theme {
  static int BACKGROUND = 0XFFCCCCCC;
  static int HIGHLIGHT = 0xFF4BD763;
  static int HEADER_BACKGROUND = 0xFF313131;
  static int BUTTON_FACE = 0xFFFFFFFF;
  static int BUTTON_DOWN = 0xFFEEEEEE;
  static int PROGRESS_BAR = 0xFFFFCC00;
  static int SCROLL_BAR_SLIDER = 0xFF4D4D4D;
  static int SCROLL_BAR_BACKGROUND = 0x0F000000;
  static int LIST_DEFAULT = 0xFFFFFFFF;
  static int LIST_ALTERNATE = 0xFFF3F3F3;
  static int LIST_SELECTED = Color.WhiteSmoke;
  static int LIST_ROLLOVER = Color.WhiteSmoke;
  static int LIST_DIVIDER = 0xFFEAEAEA;

  DefaultTheme(): super() {
    // TODO: should not create instance right now.
    register(Theme.LABEL_SKIN, new LabelSkin());
    register(Theme.ALERT_SKIN, new AlertSkin());
    register(Theme.BUTTON_SKIN, new ButtonSkin());
    register(Theme.LIST_VIEW_SKIN, new ListViewSkin());
    register(Theme.PROGRESS_BAR_SKIN, new LinearProgressBarSkin());
    register(Theme.SCROLL_BAR_SKIN, new ScrollBarSkin());
    register(Theme.TOAST_SKIN, new ToastSkin());
    register(Theme.NAVIGATION_BAR_SKIN, new NavigationBarSkin());
    register(Theme.SWITCH_SKIN, new SwitchSkin());
  }
}
