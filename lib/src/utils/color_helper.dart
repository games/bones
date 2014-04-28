part of valorzhong_bones;



class ColorHelper {
  
  static int fromRgba(int red, int green, int blue, [double alpha = 1.0]) {
    var ai = Math.min(1, Math.max(alpha, 0));
    return (ai * 255).toInt() << 24 | red << 16 | green << 8 | blue;
  }
  
}
