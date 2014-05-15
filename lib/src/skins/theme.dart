part of bones;


abstract class Theme {
  static const LABEL_SKIN = "LabelSkin";
  static const ALERT_SKIN = "AlertSkin";
  static const BUTTON_SKIN = "ButtonSkin";
  static const LIST_VIEW_SKIN = "ListViewSkin";
  static const PROGRESS_BAR_SKIN = "ProgressBarSkin";
  static const SCROLL_BAR_SKIN = "ScrollBarSkin";
  static const TOAST_SKIN = "ToastSkin";
  static const NAVIGATION_BAR_SKIN = "NavigationBarSkin";

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
    register(Theme.LABEL_SKIN, new LabelSkin());
    register(Theme.ALERT_SKIN, new AlertSkin());
    register(Theme.BUTTON_SKIN, new ButtonSkin());
    register(Theme.LIST_VIEW_SKIN, new ListViewSkin());
    register(Theme.PROGRESS_BAR_SKIN, new LinearProgressBarSkin());
    register(Theme.SCROLL_BAR_SKIN, new ScrollBarSkin());
    register(Theme.TOAST_SKIN, new ToastSkin());
    register(Theme.NAVIGATION_BAR_SKIN, new NavigationBarSkin());
  }
}

abstract class TextureAtlasSkin extends Skin {
  TextureAtlasTheme theme;
  TextureAtlasSkin([this.theme]);
  Scale9Bitmap scale9Skin(String name, Rectangle grid) => theme.scale9Skin(target, name, grid);
}

abstract class TextureAtlasTheme extends Theme {
  ResourceManager resources;
  String altas;
  TextureAtlasTheme(this.resources, this.altas): super();

  @override
  void register(String name, Skin skin) {
    super.register(name, skin);
    if (skin is TextureAtlasSkin) skin.theme = this;
  }

  Scale9Bitmap scale9Skin(Skinnable target, String name, Rectangle grid) {
    var atlas,
        texture = name;
    if (target.theme == null) {
      atlas = resources.getTextureAtlas(altas);
    } else {
      atlas = resources.getTextureAtlas(target.theme);
    }
    if (target.skinSelector != null) texture = "${target.skinSelector}-$name";
    return new Scale9Bitmap(atlas.getBitmapData(texture), grid);
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
