part of valorzhong_bones;




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

  LinearLayout({this.gap: 0, this.orientation: Orientation.HORIZONTAL, this.horizontalAlign: HorizontalAlign.LEFT, this.verticalAlign:
      VerticalAlign.TOP, this.padding: 0});

  @override
  order(Component container) {
    var w = 0,
        h = 0;
    if (horizontalAlign != HorizontalAlign.LEFT || verticalAlign != HorizontalAlign.LEFT) {
      container.forEach((int i, DisplayObject child) {
        if (!child.visible) return;
        if (orientation == Orientation.HORIZONTAL) {
          w += child.width + gap;
          h = h > child.height ? h : child.height + gap;
        } else {
          w = w > child.width ? w : child.width + gap;
          h += child.height + gap;
        }
      });
    }
    var startx = 0,
        starty = 0;
    if (horizontalAlign == HorizontalAlign.CENTER) {
      startx = (container.width - w) / 2;
    } else if (horizontalAlign == HorizontalAlign.RIGHT) {
      startx = container.width - w - gap - padding;
    } else {
      startx = padding;
    }
    if (verticalAlign == VerticalAlign.MIDDLE) {
      starty = (container.height - h) / 2;
    } else if (verticalAlign == VerticalAlign.BOTTOM) {
      starty = container.height - h - gap - padding;
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
