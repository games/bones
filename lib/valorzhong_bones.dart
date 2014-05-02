library valorzhong_bones;


import 'dart:math' as Math;

import 'package:stagexl/stagexl.dart';
import 'package:valorzhong_injector/valorzhong_injector.dart';

part 'src/application.dart';
part 'src/screen.dart';
part 'src/utils/color_helper.dart';

part 'src/controls/component.dart';
part 'src/controls/container.dart';
part 'src/controls/layout.dart';
part 'src/controls/progress_bar.dart';
part 'src/controls/button.dart';
part 'src/controls/alert.dart';

part 'src/skins/skinnable.dart';
part 'src/skins/alert_skin.dart';
part 'src/skins/button_skin.dart';





const TWO_PI = Math.PI * 2;
const num HALF_PI = Math.PI / 2;

capitalize(String str) => str[0].toUpperCase() + str.substring(1);
