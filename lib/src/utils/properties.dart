part of bones;




class Properties {

  Map<String, String> _content;

  Properties.fromString(String source) : _content = {} {
    var lines = source.split("\n");
    var key = "",
        value = "",
        formerKey = "",
        formerValue = "",
        useNextLine = false;

    lines.forEach((line) {
      line = line.trim();
      if (line.startsWith("[")) {
        //TODO : parse group
      } else if (!line.startsWith("#") && line.indexOf("!") != 0 && line.length != 0) {
        if (useNextLine) {
          key = formerKey;
          value = formerValue + line;
          useNextLine = false;
        } else {
          var sep = _getSeparation(line);
          key = line.substring(0, sep).trimRight();
          value = line.substring(sep + 1);
          formerKey = key;
          formerValue = value;
        }
        value = value.trimLeft();
        if (value.endsWith("\\")) {
          formerValue = value = value.substring(0, value.length - 1);
          useNextLine = true;
        } else {
          add(key, value);
        }
      }
    });
  }

  add(String key, String value) {
    _content[key] = value;
  }

  String get(String key, [String defVal = ""]) {
    if (_content.containsKey(key)) {
      return _content[key];
    }
    return defVal;
  }

  String format(String key, List args) {
    var txt = get(key);
    for (var i = 0; i < args.length; i++) {
      txt = txt.replaceFirst("{$i}", args[i]);
    }
    return txt;
  }

  int getInt(String key, [int defVal = 0]) {
    if (_content.containsKey(key)) {
      return int.parse(_content[key], onError: (k) => defVal);
    }
    return defVal;
  }

  bool getBool(String key, [bool defVal = false]) {
    if (_content.containsKey(key)) {
      return _content[key].toLowerCase() == "true";
    }
    return defVal;
  }

  final int quotes = "'".codeUnitAt(0);
  final int colon = ":".codeUnitAt(0);
  final int equal = "=".codeUnitAt(0);
  final int space = " ".codeUnitAt(0);

  int _getSeparation(String line) {
    var l = line.length,
        i = 0;
    for (i = 0; i < l; i++) {
      var c = line.codeUnitAt(i);
      if (c == quotes) {
        i++;
      } else {
        if (c == colon || c == equal || c == space) break;
      }
    }
    return ((i == l) ? line.length : i);
  }
}
