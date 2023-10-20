import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

const TYPE = "type";
const ARGS = "args";

@lazySingleton
class NotificationNavigator {
  void navigateNotification({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) {
    _parse(context, data);
  }

  void _parse(BuildContext context, Map<String, dynamic> data) {
    String? type = data[TYPE];
  }
}
