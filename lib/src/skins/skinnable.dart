part of valorzhong_bones;




abstract class Skin {
  Skinnable target;
  apply();
}


abstract class Skinnable extends Component {
  Skin _skin;

  Skinnable(): super() {
    repaint();
  }

  Skin get defaultSkin;

  set skin(Skin val) {
    _skin = val;
    _skin.target = this;
    repaint();
  }

  @override
  repaint() {
    super.repaint();
    if (_skin == null) {
      _skin = defaultSkin;
      _skin.target = this;
    }
    _skin.apply();
  }
}
