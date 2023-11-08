import 'package:flutter/foundation.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    if (kDebugMode) {
      print(this);
    }
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// Print Long String
  void printLongString() {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(this)
        // ignore: avoid_print
        .forEach((RegExpMatch match) => print(match.group(0)));
  }
}
