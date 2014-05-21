import 'dart:html' as html;
import 'dart:async';
import 'package:stagexl/stagexl.dart';
import 'package:stats/stats.dart';
import 'package:bones/bones.dart';


void main() {
  var canvas = html.querySelector("#stage");
  var stage = new Stage(canvas, width: canvas.clientWidth, height: canvas.clientHeight, color: Color.White, webGL: true);
  stage.scaleMode = StageScaleMode.NO_SCALE;
  stage.align = StageAlign.NONE;
  Application.instance.startup(stage);
  Application.instance.replace(new EntriesScreen());
}

class EntriesScreen extends Screen {

  @override
  enter() {
    var listView = new ListView()
        ..data = [{
            "label": "Alert",
            "icon": new Box(32, 32, Color.Red)
          }, {
            "label": "Button/Switch",
            "icon": new Box(32, 32, Color.Blue)
          }, {
            "label": "ButtonGroup",
            "icon": new Box(32, 32, Color.Green)
          }, {
            "label": "Label",
            "icon": new Box(32, 32, Color.Green)
          }, {
            "label": "ListView",
            "icon": new Box(32, 32, Color.Green)
          }, {
            "label": "NavigationBar",
            "icon": new Box(32, 32, Color.Green)
          }, {
            "label": "ProgressBar",
            "icon": new Box(32, 32, Color.Green)
          }, {
            "label": "ScrollBar",
            "icon": new Box(32, 32, Color.Green)
          }, {
            "label": "ScrollView",
            "icon": new Box(32, 32, Color.Green)
          }, {
            "label": "Toast",
            "icon": new Box(32, 32, Color.Green)
          }]
        ..itemWidth = stage.sourceWidth;
    addChild(new ScrollView()
        ..size(stage.sourceWidth, stage.sourceHeight)
        ..content = listView);
  }

  @override
  exit() {
    // TODO: implement exit
  }
}
