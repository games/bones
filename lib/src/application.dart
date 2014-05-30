part of bones;



const EventStreamProvider<Event> screenAddedEvent = const EventStreamProvider<Event>(Application.SCREEN_ADDED);

class Application extends EventDispatcher {
  static final Application _singleton = new Application._internal();
  static Application get instance => _singleton;
  factory Application() => _singleton;

  static const SCREEN_ADDED = "screen_added";

  EventStream<Event> get onScreenAdded => screenAddedEvent.forTarget(this);

  Stage _stage;
  RenderLoop _renderLoop;
  List<Screen> _screens;
  Injector _injector;
  bool _isIos = false,
      _isAndroid = false,
      _isBlackberry = false,
      _isWindows = false,
      _isMobile = false;

  bool get isIos => _isIos;
  bool get isAndroid => _isAndroid;
  bool get isBlackberry => _isBlackberry;
  bool get isWindows => _isWindows;
  bool get isMobile => _isMobile;

  Application._internal() {
    _screens = [];
  }

  startup(Stage stage) {
    _isMobile = Stage.isMobile;
    if (_isMobile) {
      _isIos = Html.window.navigator.userAgent.contains(new RegExp("iPad|iPhone|iPod"));
      _isAndroid = Html.window.navigator.userAgent.contains("Android");
      _isBlackberry = Html.window.navigator.userAgent.contains("BlackBerry");
      _isWindows = Html.window.navigator.userAgent.contains("IEMobile");
    }
    _stage = stage;
    _stage.onResize.listen(_resizeHandler);
    _renderLoop = new RenderLoop();
    _renderLoop.addStage(stage);
    _renderLoop.start();
    _injector = new Injector();
    _injector.map(Stage).toValue(_stage);
    _injector.map(ResourceManager).asSingleton();
  }

  replace(Screen scr, [intent]) {
    pop();
    push(scr, intent);
  }

  push(Screen scr, [intent]) {
    if (_screens.length > 0) {
      screen.unfocus();
    }
    _screens.add(scr);
    _stage.addChild(scr);
    _injector.inject(scr);
    scr.intent = intent;
    scr.enter();
    scr.focus();
    dispatchEvent(new Event(SCREEN_ADDED));
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

  InjectionMapping map(Type type, [String name = ""]) => _injector.map(type, name);
  take(Type t, [String name = ""]) => _injector.get(t, name);

  Screen get screen => _screens.last;
  Stage get stage => _stage;

  void _resizeHandler(Event event) {
    _screens.forEach((scr) => scr.dispatchEvent(event));
  }
}
