import 'dart:html' as html;
import 'dart:async';
import 'package:stagexl/stagexl.dart';
import 'package:stats/stats.dart';
import 'package:bones/bones.dart';




void main() {
  var canvas = html.querySelector("#stage");



  var stage = new Stage(canvas, width: canvas.clientWidth, height: canvas.clientHeight, color: Color.SkyBlue, webGL: true);
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

    var stats = new Stats();
    html.document.body.children.add(stats.container);
    stage.onEnterFrame.listen((e) => stats.begin());
    stage.onExitFrame.listen((e) => stats.end());

    var toast = new Toast()..move(300, 300);
    toast.show("Welcome!!");
    addChild(toast);

    addChild(new Button()
        ..text = "Click Me!!"
        ..onPressed.listen((e) {
          var alert = PopupManager.message("Great!!", title: "Title", buttonsDefs: Alert.BUTTONS_OK_CANCEL, bodyWidth: 200, bodyHeight: 100);
          alert.on(Event.OKAY).listen((e2) => toast.show("You selected the OKAY!"));
          alert.on(Event.CANCEL).listen((e2) => toast.show("You selected the CANCEL!"));
        })
        ..move(1, 1));

    var progressBar = new ProgressBar()
        ..periodic = true
        ..value = 40
        ..move(160, 10);
    addChild(progressBar);

    var countdown = new ProgressBar(new CountdownSkin())
        ..periodic = true
        ..value = 45
        ..move(320, 10);
    addChild(countdown);

    var t = new Timer.periodic(new Duration(milliseconds: 33), (t) {
      progressBar.step();
      countdown.step();
    });

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
        ..content = DisplayObjectHelper.toScale9Bitmap(new Shape()
            ..graphics.rect(0, 0, 300, 300)
            ..graphics.fillGradient(gradient), new Rectangle(2, 2, 10, 10)));

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
