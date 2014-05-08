import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:valorzhong_bones/valorzhong_bones.dart';




void main() {
  var canvas = html.querySelector("#stage");

  var stage = new Stage(canvas, width: canvas.clientWidth, height: canvas.clientHeight, color: Color.SkyBlue, webGL: false);
  stage.scaleMode = StageScaleMode.NO_SCALE;
  stage.align = StageAlign.NONE;

  Application.instance.startup(stage);
  Application.instance.replace(new TestScreen());
}

class TestScreen extends Screen {
  @override
  enter() {

    graphics.clear();
    graphics.rect(0, 0, stage.sourceWidth, stage.sourceHeight);
    graphics.fillColor(Color.SkyBlue);


    var toast = new Toast();
    toast.x = 300;
    toast.y = 300;
    addChild(toast);

    addChild(new Button()
        ..text = "Click Me!!"
        ..onPressed.listen((e) {
          var alert = PopupManager.message("Great!!", title: "Title", buttonsDefs: Alert.BUTTONS_OK_CANCEL, bodyWidth: 200, bodyHeight: 100);
          alert.on(Event.OKAY).listen((e2) => toast.show("You selected the OKAY!"));
          alert.on(Event.CANCEL).listen((e2) => toast.show("You selected the CANCEL!"));
        })
        ..move(1, 1));

    addChild(new ProgressBar()
        ..value = 40
        ..move(120, 10));

    addChild(new ProgressBar(new CountdownSkin())
        ..value = 45
        ..move(320, 10));

    addChild(new ScrollBar()
        ..range = 10
        ..value = 10
        ..move(10, 60));

    addChild(new ScrollBar(orientation: Orientation.HORIZONTAL)
        ..range = 25
        ..value = 87
        ..move(20, 60));

    var gradient = new GraphicsGradient.linear(0, 0, 300, 300);
    gradient.addColorStop(0, 0xFF8ED6FF);
    gradient.addColorStop(1, 0xFF004CB3);

    addChild(new ScrollView()
        ..size(150, 100)
        ..move(30, 100)
        ..addChild(new Shape()
            ..graphics.rect(0, 0, 300, 300)
            ..graphics.fillGradient(gradient)));

    var listView = new ListView()
        ..data = [{
            "label": "CLOSE MENU",
            "icon": new Box(32, 32, Color.Red)
          }, {
            "label": "CHANGE LIMIT",
            "icon": new Box(32, 32, Color.Blue)
          }, {
            "label": "HISTORY",
            "icon": new Box(32, 32, Color.Green)
          }]
        ..move(50, 210);
    addChild(listView);
  }

  @override
  exit() {
    // TODO: implement exit
  }
}
