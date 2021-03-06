import 'dart:html' as html;
import 'dart:async';
import 'dart:math';
import 'package:stagexl/stagexl.dart';
import 'package:stats/stats.dart';
import 'package:bones/bones.dart';




void main() {
  var canvas = html.querySelector("#stage");



  var stage = new Stage(canvas, width: canvas.clientWidth, height: canvas.clientHeight, color: Color.White, webGL: true);
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
    graphics.fillColor(Color.White);

    var stats = new Stats();
    html.document.body.children.add(stats.container);
    stage.onEnterFrame.listen((e) => stats.begin());
    stage.onExitFrame.listen((e) => stats.end());

    var toast = new Toast()..move(300, 300);
    toast.show("Welcome!!");

    addChild(new Button()
        ..text = "Click Me!!"
        ..move(300, 200)
        ..onPressed.listen((e) {
          var alert = PopupManager.message("I just wanted you to know that I have a very\n important message to share with you.", title: "Title", buttonsDefs: Alert.BUTTONS_OK_CANCEL);
          alert.on(Event.OKAY).listen((e2) => toast.show("You selected the OKAY!"));
          alert.on(Event.CANCEL).listen((e2) => toast.show("You selected the CANCEL!"));
        }));

    var progressBar = new ProgressBar()
        ..periodic = true
        ..value = 40
        ..move(200, 150);
    addChild(progressBar);

    var countdown = new ProgressBar(new CountdownSkin())
        ..periodic = true
        ..value = 45
        ..move(400, 50);
    addChild(countdown);

    var label = new Label();
    label.description = "计时：";
    label
        ..move(300, 350)
        ..size(150, 30);
    addChild(label);

    var t = new Timer.periodic(new Duration(milliseconds: 33), (t) {
      progressBar.step();
      countdown.step();
      label.text = "${countdown.value} 秒";
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
        ..content = new ListView(data: [{
            "label": "CLOSE MENU",
            "icon": new Box(32, 32, Color.Red)
          }, {
            "label": "CHANGE LIMIT",
            "icon": new Box(32, 32, Color.Blue)
          }, {
            "label": "HISTORY",
            "icon": new Box(32, 32, Color.Green)
          }]));

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

    var navigationBar = new NavigationBar();
    navigationBar.title = "Navigation Bar";
    addChild(navigationBar);

    var rand = new Random();
    addChild(new Switch()
        ..move(350, 250)
        ..onChange.listen((e) => listView.data = _generateListData()));

    addChild(new ListPicker()
        ..move(300, 300)
        ..data = _generateListData());
    

    addChild(toast);
  }

  _generateListData() {
    var rand = new Random();
    var len = rand.nextInt(5) + 1;
    var result = [];
    for (var i = 0; i < len; i++) {
      var c = rand.nextInt(0xFFFFFFFF);
      result.add({
        "label": ColorHelper.toRgba(c).toString(),
        "icon": new Box(32, 32, c)
      });
    }
    return result;
  }

  @override
  exit() {
    // TODO: implement exit
  }
}
