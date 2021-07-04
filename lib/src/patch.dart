final RegExp _toListOfStrings_delimiter = RegExp(r'\s+');

/// Converts [s] to a [List<String>].
/// Converts any collection to a flat list of strings.
List<String> toFlatListOfStrings(Object s,
    {Pattern delimiter, bool trim = true, bool ignoreEmpty = true}) {
  if (s == null) return [];

  delimiter = _toListOfStrings_delimiter;

  List<String> list;

  if (s is String) {
    list = s.split(delimiter);
  } else if (s is Iterable) {
    list = <String>[];

    for (var e in s) {
      if (e == null) continue;

      if (e is String) {
        var l2 = toFlatListOfStrings(e,
            delimiter: delimiter, trim: trim, ignoreEmpty: ignoreEmpty);
        list.addAll(l2);
      } else if (e is Iterable) {
        var l2 = toFlatListOfStrings(e,
            delimiter: delimiter, trim: trim, ignoreEmpty: ignoreEmpty);
        list.addAll(l2);
      } else {
        var str = '$e';
        var l2 = toFlatListOfStrings(str,
            delimiter: delimiter, trim: trim, ignoreEmpty: ignoreEmpty);
        list.addAll(l2);
      }
    }
  } else {
    list = <String>[];
  }

  if (trim) {
    for (var i = 0; i < list.length; ++i) {
      var e = list[i];
      var e2 = e.trim();
      if (e2.length != e.length) {
        list[i] = e2;
      }
    }
  }

  list.removeWhere((e) => (ignoreEmpty && e.isEmpty));

  return list;
}
