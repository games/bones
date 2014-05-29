part of bones;




class ListPicker extends Component {

  EventStream<Event> get onItemSelected => itemSelectedEvent.forTarget(this);

  Skin listSkin;
  Skin buttonSkin;
  PopupList list;
  Button button;
  LabelFactory labelFactory;
  String defaultLabel = "Pick";

  List _data;

  ListPicker({this.listSkin, this.buttonSkin}) : super() {
    button = new Button();
    list = new PopupList();
  }

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
    if (labelFactory == null) labelFactory = (d) => d.toString();

    list
        ..skin = listSkin
        ..data = _data
        ..itemWidth = stage.sourceWidth
        ..onItemSelected.listen(_listItemSelectedHandler);

    button
        ..skin = buttonSkin
        ..onPressed.listen(_pressButtonHandler)
        ..text = defaultLabel;
    if (width != 0) button.width = width;
    if (height != 0) button.height = height;

    addChild(button);

    size(button.width, button.height);
  }

  @override
  repaint() {
    super.repaint();
    _updateButtonLabel();
  }

  int get selectedIndex => list.selectedIndex;
  
  DisplayObject get selectedItem => list.selectedItem;
  
  get selectedData => list.selectedData;

  void _listItemSelectedHandler(Event event) {
    list.close();
    _updateButtonLabel();
    dispatchEvent(new Event(ListView.EVENT_ITEM_SELECTED));
  }

  void _pressButtonHandler(Event event) {
    PopupManager.show(list);
  }

  void _updateButtonLabel() {
    var d = selectedData;
    if (d != null) button.text = labelFactory(d); else button.text = defaultLabel;
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

























