import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:valorzhong_bones/valorzhong_bones.dart';




void main() {
  var canvas = html.querySelector("#stage");

  var stage = new Stage(canvas, width: canvas.clientWidth, height: canvas.clientHeight, color: Color.Black, webGL: false);
  stage.scaleMode = StageScaleMode.SHOW_ALL;
  stage.align = StageAlign.NONE;

  Application.instance.startup(stage);
  Application.instance.replace(new TestScreen());
}

class TestScreen extends Screen {
  @override
  enter() {
    var btn = new Button()
        ..text = "Click Me!!"
        ..move(100, 100);
    addChild(btn);
  }

  @override
  exit() {
    // TODO: implement exit
  }
}
