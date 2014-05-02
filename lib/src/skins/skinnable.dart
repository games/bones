part of valorzhong_bones;




abstract class Renderer {
  Skinnable target;
  render();
}


abstract class Skinnable extends Component {
  Renderer _renderer;

  Skinnable(): super() {
    repaint();
  }

  Renderer get defaultRenderer;

  set renderer(Renderer val) {
    _renderer = val;
    _renderer.target = this;
    repaint();
  }

  @override
  repaint() {
    super.repaint();
    if (_renderer == null) {
      _renderer = defaultRenderer;
      _renderer.target = this;
    }
    _renderer.render();
  }
}
