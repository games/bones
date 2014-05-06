part of valorzhong_bones;




abstract class Skin {
  Skinnable target;
  // TODO : These properties are requirement for all skins, should be move into component?
  num width, height;
  apply();
}


abstract class Skinnable extends Component {
  Skin _skin;

  Skinnable(this._skin): super() {
    repaint();
    _invalid = false;
  }

  Skin get defaultSkin;

  Skin get skin => _skin;

  void set skin(Skin val) {
    _skin = val;
    _skin.target = this;
    repaint();
  }

  @override
  repaint() {
    super.repaint();
    if (_skin == null) {
      _skin = defaultSkin;
    }
    _skin.target = this;
    _skin.apply();
  }
}
