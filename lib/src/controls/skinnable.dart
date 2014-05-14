part of bones;




abstract class Skin {
  Skinnable target;
  apply();
  repaint() {}
}


abstract class Skinnable extends Component {
  Skin _skin;
  String theme;
  String skinSelector;

  Skinnable(this._skin): super();

  // TODO : should not apply skin until the component be added to stage/parent?
  @override
  initialize() {
    super.initialize();
    if (_skin == null) {
      _skin = defaultSkin;
    }
    _skin.target = this;
    _skin.apply();
  }

  Skin get defaultSkin => ThemeManager.theme.takeFor(skinName + "Skin");

  Skin get skin => _skin;
  
  String get skinName;

  void set skin(Skin val) {
    _skin = val;
    _skin.target = this;
    repaint();
  }

  @override
  repaint() {
    super.repaint();
    _skin.target = this;
    _skin.repaint();
  }
}
