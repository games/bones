part of bones;




class DefaultTheme extends Theme {
  static const BACKGROUND = 0XFFCCCCCC;
  static const HIGHLIGHT = 0xFF4BD763;
  static const BUTTON_FACE = 0xFFFFFFFF;
  static const BUTTON_DOWN = 0xFFEEEEEE;
  static const PROGRESS_BAR = 0xFFFFCC00;
  static const SCROLL_BAR_SLIDER = 0xFF4D4D4D;
  static const SCROLL_BAR_BACKGROUND = 0x0F000000;
  static const LIST_DEFAULT = 0xFFFFFFFF;
  static const LIST_ALTERNATE = 0xFFF3F3F3;
  static const LIST_SELECTED = Color.WhiteSmoke;
  static const LIST_ROLLOVER = Color.WhiteSmoke;

  static const LIST_DIVIDER = 0xFFEAEAEA;

  DefaultTheme(): super() {
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
