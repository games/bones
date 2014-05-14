part of bones;



class DisplayObjectHelper {
  static Scale9Bitmap toScale9Bitmap(DisplayObject drawable, Rectangle grid) {
    return new Scale9Bitmap(new BitmapData(drawable.width.toInt(), drawable.height.toInt(), true, 0x00FFFFFF)..draw(drawable), grid);
  }
}
