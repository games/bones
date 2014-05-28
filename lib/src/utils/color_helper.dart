part of bones;



class ColorHelper {

  static int fromRgba(int red, int green, int blue, [double alpha = 1.0]) {
    var ai = Math.min(1, Math.max(alpha, 0));
    return (ai * 255).toInt() << 24 | red << 16 | green << 8 | blue;
  }

  static Colour toRgba(int hex) {
    int a = (hex >> 24) & 0xFF;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = hex & 0xFF;
    return new Colour(r, g, b, (a / 255));
  }

}

class Colour {
  final double alpha;
  final int red;
  final int green;
  final int blue;
  Colour(this.red, this.green, this.blue, [this.alpha = 1.0]);

  @override
  String toString() {
    return "R:$red G:$green B:$blue A:${alpha.toStringAsPrecision(2)}";
  }
}
