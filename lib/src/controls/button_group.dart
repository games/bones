part of bones;


const EventStreamProvider<ButtonGroupEvent> selectedEvent = const EventStreamProvider<ButtonGroupEvent>(ButtonGroupEvent.SELECTED);

class ButtonGroupEvent extends Event {
  static const String SELECTED = "BUTTONGROUP_SELECTED";
  Button button;
  String event;
  ButtonGroupEvent(this.button, this.event): super(SELECTED);
}

class ButtonGroup extends Container {

  EventStream<ButtonGroupEvent> get onSelected => selectedEvent.forTarget(this);

  List<ButtonDef> buttonDefs;

  ButtonGroup(this.buttonDefs, [Layout layout]): super(layout);

  @override
  initialize() {
    super.initialize();
    buttonDefs.forEach((def) {
      var btn = new Button(skin: def.skin)..text = def.label;
      // TODO : incorrect button reference.
      if (def.event != null) btn.onPressed.listen((e) {
        dispatchEvent(new ButtonGroupEvent(btn, def.event));
      });
      addChild(btn);
    });
    order();
  }

  @override
  Layout get defaultLayout => new LinearLayout(gap: 5, orientation: Orientation.HORIZONTAL, horizontalAlign: HorizontalAlign.CENTER, verticalAlign: VerticalAlign.MIDDLE);
}

class ButtonDef {
  final String label;
  final String event;
  final Skin skin;
  const ButtonDef({this.label: "", this.event, this.skin: null});
}
