part of bones;



typedef String PickerLabelFactory(ListPicker picker, data);

class ListPicker extends Component {

  Skin listSkin;
  Skin buttonSkin;
  PopupList list;
  Button button;
  PickerLabelFactory labelFactory;
  String defaultLabel = "Pick";

  List _data;

  ListPicker({this.listSkin, this.buttonSkin}) : super();

  void set data(List val) {
    _data = val;
    if (list != null) list.data = _data;
    invalidate();
  }

  @override
  initialize() {
    super.initialize();
    if (listSkin == null) listSkin = ThemeManager.theme.takeFor(Theme.LIST_VIEW_SKIN);
    if (buttonSkin == null) buttonSkin = ThemeManager.theme.takeFor(Theme.BUTTON_SKIN);
    if (labelFactory == null) labelFactory = (p, d) => d.toString();

    list = new PopupList(skin: listSkin)
        ..data = _data
        ..itemWidth = stage.sourceWidth
        ..onItemSelected.listen(_listItemSelectedHandler);

    button = new Button(skin: buttonSkin)
        ..onPressed.listen(_pressButtonHandler)
        ..text = defaultLabel;

    addChild(button);
  }

  @override
  repaint() {
    super.repaint();
    _updateButtonLabel();
  }

  void _listItemSelectedHandler(Event event) {
    list.close();
    _updateButtonLabel();
  }

  void _pressButtonHandler(Event event) {
    PopupManager.show(list);
  }

  void _updateButtonLabel() {
    var d = list.selectedData;
    if (d != null) button.text = labelFactory(this, d); else button.text = defaultLabel;
  }
}


class PopupList extends ListView implements Popup {

  PopupList({Skin skin}) : super(skin: skin);

  @override
  bool get cover => true;

  @override
  HorizontalAlign get hAlign => HorizontalAlign.CENTER;

  @override
  EventStream<Event> get onClose => closeEvent.forTarget(this);

  @override
  VerticalAlign get vAlign => VerticalAlign.BOTTOM;

  void close() {
    dispatchEvent(new Event(Event.CLOSE));
  }
}































