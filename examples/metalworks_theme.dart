import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stats/stats.dart';
import 'package:bones/bones.dart';
import 'package:bones/theme_metalworks.dart';
import 'package:valorzhong_injector/valorzhong_injector.dart';
import 'dart:async';




void main() {
  var canvas = html.querySelector("#stage");

  var stage = new Stage(canvas, width: canvas.clientWidth, height: canvas.clientHeight, color: ColorHelper.fromRgba(74, 65, 55), webGL: true);
  stage.scaleMode = StageScaleMode.NO_SCALE;
  stage.align = StageAlign.NONE;

  Application.instance.startup(stage);
  Application.instance.replace(new LoadTheme());
}

class LoadTheme extends Screen {

  @inject
  ResourceManager resources;

  @override
  enter() {
    var label = new TextField()
        ..autoSize = TextFieldAutoSize.LEFT
        ..text = "Loading...";
    label.x = (stage.sourceWidth - label.width) / 2;
    label.y = (stage.sourceHeight - 100);
    addChild(label);

    resources
        ..addTextureAtlas("theme", "theme/metalworks.json", TextureAtlasFormat.JSON)
        ..load().then((e) => Application.instance.replace(new TestScreen()));
  }

  @override
  exit() {
    // TODO: implement exit
  }
}

class TestScreen extends Screen {
  @inject
  ResourceManager resources;

  @override
  enter() {

    graphics.clear();
    graphics.rect(0, 0, stage.sourceWidth, stage.sourceHeight);
    graphics.fillColor(Color.SkyBlue);

    ThemeManager.theme = new MetalworksTheme(resources, "theme");

    var btn = new Button();
    btn
        ..text = "Button"
        ..onPressed.listen((e) => PopupManager.message("I just wanted you to know that I have a very\n important message to share with you.", title: "Alert", buttonsDefs: Alert.BUTTONS_OK_CANCEL))
        ..move(10, 10);
    addChild(btn);

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
        ..move(250, 70);
    addChild(listView);

    var progressBar = new ProgressBar()
        ..periodic = true
        ..value = 40
        ..move(120, 10);
    addChild(progressBar);

    var t = new Timer.periodic(new Duration(milliseconds: 33), (t) {
      progressBar.step();
    });

    addChild(new ScrollBar()
        ..range = 10
        ..value = 10
        ..move(10, 90));

    addChild(new ScrollBar(orientation: Orientation.HORIZONTAL)
        ..range = 25
        ..value = 87
        ..move(20, 70));

    var gradient = new GraphicsGradient.linear(0, 0, 300, 300);
    gradient.addColorStop(0, 0xFF8ED6FF);
    gradient.addColorStop(1, 0xFF004CB3);

    addChild(new ScrollView()
        ..size(150, 100)
        ..move(30, 100)
        ..addChild(createScale9Bitmap(new Shape()
            ..graphics.rect(0, 0, 300, 300)
            ..graphics.fillGradient(gradient), new Rectangle(2, 2, 10, 10))));
  }

  @override
  exit() {
    // TODO: implement exit
  }
}
