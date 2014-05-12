part of bones;




class TextImageRelation {
  static const TextImageRelation IMAGE_ABOVE_TEXT = const TextImageRelation._(0);
  static const TextImageRelation IMAGE_BEFORE_TEXT = const TextImageRelation._(1);
  static const TextImageRelation OVERLAY = const TextImageRelation._(2);
  static const TextImageRelation TEXT_ABOVE_IMAGE = const TextImageRelation._(3);
  static const TextImageRelation TEXT_BEFORE_IMAGE = const TextImageRelation._(4);
  final int _value;
  const TextImageRelation._(this._value);
}


class Orientation {
  static const Orientation HORIZONTAL = const Orientation._(0);
  static const Orientation VERTICAL = const Orientation._(1);
  final int _value;
  const Orientation._(this._value);
}

class HorizontalAlign {
  static const HorizontalAlign LEFT = const HorizontalAlign._(0);
  static const HorizontalAlign CENTER = const HorizontalAlign._(1);
  static const HorizontalAlign RIGHT = const HorizontalAlign._(2);
  final int _value;
  const HorizontalAlign._(this._value);
}

class VerticalAlign {
  static const VerticalAlign TOP = const VerticalAlign._(0);
  static const VerticalAlign MIDDLE = const VerticalAlign._(1);
  static const VerticalAlign BOTTOM = const VerticalAlign._(2);
  final int _value;
  const VerticalAlign._(this._value);
}


abstract class Layout {
  order(Component container);
}

class EmptyLayout implements Layout {
  @override
  order(Component container) {}
}

class SingleLayout implements Layout {

  HorizontalAlign horizontalAlign;
  VerticalAlign verticalAlign;

  SingleLayout({this.horizontalAlign: HorizontalAlign.LEFT, this.verticalAlign: VerticalAlign.TOP});

  @override
  order(Component container) {
    if (container.numChildren == 0) return;
    var xp, yp;
    if (horizontalAlign == HorizontalAlign.LEFT) {
      xp = (child) => child.x = 0;
    } else if (horizontalAlign == HorizontalAlign.CENTER) {
      xp = (child) => child.x = (container.width - child.width) / 2;
    } else {
      xp = (child) => child.x = container.width - child.width;
    }
    if (verticalAlign == VerticalAlign.TOP) {
      yp = (child) => child.y = 0;
    } else if (verticalAlign == VerticalAlign.MIDDLE) {
      yp = (child) => child.y = (container.height - child.height) / 2;
    } else {
      xp = (child) => child.y = container.height - child.height;
    }
    container.forEach((int i, DisplayObject child) {
//      if (child is Component) child.measure;
      xp(child);
      yp(child);
    });
  }
}

class LinearLayout implements Layout {
  int gap, padding;
  HorizontalAlign horizontalAlign;
  VerticalAlign verticalAlign;
  Orientation orientation;

  LinearLayout({this.gap: 0, this.orientation: Orientation.HORIZONTAL, this.horizontalAlign: HorizontalAlign.LEFT, this.verticalAlign: VerticalAlign.TOP, this.padding: 0});

  @override
  order(Component container) {
    if (container.numChildren == 0) return;
    var w = 0,
        h = 0;
    if (horizontalAlign != HorizontalAlign.LEFT || verticalAlign != HorizontalAlign.LEFT) {
      container.forEach((int i, DisplayObject child) {
        if (!child.visible) return;
//        if (child is Component) child.measure();
        if (orientation == Orientation.HORIZONTAL) {
          w += child.width + gap;
          h = h > child.height ? h : child.height + gap;
        } else {
          w = w > child.width ? w : child.width + gap;
          h += child.height + gap;
        }
      });
    }

    w -= gap;
    h -= gap;

    var startx = 0,
        starty = 0;

    // *** correct ? ***
    var dp = padding * 2;
    if (container is Container && container.autoResize) {
      container.size(w + dp, h + dp);
    }
    var cw = container.width,
        ch = container.height;
    // *****************

    if (horizontalAlign == HorizontalAlign.CENTER) {
      startx = (cw - w) / 2;
    } else if (horizontalAlign == HorizontalAlign.RIGHT) {
      startx = cw - w - gap - padding;
    } else {
      startx = padding;
    }
    if (verticalAlign == VerticalAlign.MIDDLE) {
      starty = (ch - h) / 2;
    } else if (verticalAlign == VerticalAlign.BOTTOM) {
      starty = ch - h - gap - padding;
    } else {
      starty = padding;
    }
    var step;
    if (orientation == Orientation.HORIZONTAL) {
      step = (child) => startx += child.width + gap;
    } else {
      step = (child) => starty += child.height + gap;
    }
    container.forEach((i, child) {
      if (!child.visible) return;
      child.x = startx;
      child.y = starty;
      step(child);
    });
  }
}

typedef ZipLayoutInterpolater(DisplayObject child);

class ZipLayout implements Layout {
  int gap;
  ZipLayoutInterpolater interpolater;

  ZipLayout({this.gap: 5, this.interpolater});

  @override
  order(Component container) {
    if (container.numChildren == 0) return;
    var halfWidth = container.width / 2;
    container.forEach((int position, DisplayObject child) {
      var diretion = position % 2 == 0 ? -1 : 1;
      var pos = position + 1;
      if (diretion == -1) {
        pos = pos ~/ 2 + 1;
      } else {
        pos = pos / 2;
      }
      pos *= diretion;
      child.x = pos * child.width + gap * diretion + halfWidth;
      if (interpolater != null) interpolater(child);
    });
  }
}
