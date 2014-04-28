part of valorzhong_bones;


class Application {
  static final Application _singleton = new Application._internal();
  static Application get instance => _singleton;
  factory Application() => _singleton;

  Stage _stage;
  RenderLoop _renderLoop;
  List<Screen> _screens;
  Injector _injector;

  Application._internal() {
    _screens = [];
  }

  startup(Stage stage) {
    _stage = stage;
    _renderLoop = new RenderLoop();
    _renderLoop.addStage(stage);
    _renderLoop.start();
    _injector = new Injector();
    _injector.map(Stage).toValue(_stage);
    _injector.map(ResourceManager).asSingleton();
  }

  replace(Screen scr) {
    pop();
    push(scr);
  }

  push(Screen scr) {
    if (_screens.length > 0) {
      screen.unfocus();
    }
    _screens.add(scr);
    _stage.addChild(scr);
    _injector.inject(scr);
    scr.enter();
    scr.focus();
  }

  pop() {
    if (_screens.length > 0) {
      remove(screen);
    }
  }

  remove(Screen scr) {
    if (scr == screen) {
      scr.unfocus();
    }
    scr.exit();
    _stage.removeChild(scr);
    _screens.remove(scr);
    if (_screens.length > 0) {
      screen.focus();
    }
  }
  
  take(Type t, [String name = ""]) => _injector.get(t, name);

  Screen get screen => _screens.last;
  Stage get stage => _stage;
}
















