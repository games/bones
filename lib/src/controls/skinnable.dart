part of bones;




abstract class Skin {
  Skinnable target;
  apply();
  repaint() {}
}


abstract class Skinnable extends Component {
  Skin _skin;

  Skinnable(this._skin): super();

  @override
  initialize() {
    super.initialize();
    if (_skin == null) {
      _skin = defaultSkin;
    }
    _skin.target = this;
    _skin.apply();
  }

  Skin get defaultSkin => ThemeManager.theme.takeFor(runtimeType.toString() + "Skin");

  Skin get skin => _skin;

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
