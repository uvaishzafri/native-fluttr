import 'package:flutter/material.dart';

class ContentNotFound extends StatelessWidget {
  final String message;
  final double height;

  const ContentNotFound(this.message, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 60,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 28),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xff1E1E1E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}
