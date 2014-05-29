part of bones;




class Scale9Textures {
  BitmapData bitmapData;
  Rectangle grid;
  Scale9Textures(this.bitmapData, this.grid);

  Scale9Bitmap get bitmap => new Scale9Bitmap(bitmapData, grid);
}
