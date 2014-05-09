part of valorzhong_bones;


abstract class Theme {
  static const ALERT_SKIN = "AlertSkin";
  static const BUTTON_SKIN = "ButtonSkin";
  static const LIST_VIEW_SKIN = "ListViewSkin";
  static const PROGRESS_BAR_SKIN = "ProgressBarSkin";
  static const SCROLL_BAR_SKIN = "ScrollBarSkin";
  static const TOAST_SKIN = "ToastSkin";

  Map<String, Skin> _skins;

  Theme(): _skins = {};

  void register(String name, Skin skin) {
    if (_skins.containsKey(name)) throw new ArgumentError("Duplicate skin[$name] exists.");
    _skins[name] = skin;
  }

  Skin takeFor(String name) => _skins[name];
}

class DefaultTheme extends Theme {
  DefaultTheme(): super() {
    register(Theme.ALERT_SKIN, new AlertSkin());
    register(Theme.BUTTON_SKIN, new ButtonSkin());
    register(Theme.LIST_VIEW_SKIN, new ListViewSkin());
    register(Theme.PROGRESS_BAR_SKIN, new LinearProgressBarSkin());
    register(Theme.SCROLL_BAR_SKIN, new ScrollBarSkin());
    register(Theme.TOAST_SKIN, new ToastSkin());
  }
}

//const EventStreamProvider<Event> onChangeEvent = new EventStreamProvider<Event>(Event.CHANGE);

class ThemeManager {
//  EventStream<Event> static get onChanged => onChangeEvent.forTarget(this);

  static Theme _theme;

  static Theme get theme {
    if (_theme == null) _theme = new DefaultTheme();
    return _theme;
  }

  static void set theme(Theme val) {
    _theme = val;
    // TODO : dispatch changed event.
  }

}
