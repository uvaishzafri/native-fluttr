import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderPage extends StatelessWidget {
  final String imageAddress, title;
  final int index;

  const SliderPage({required this.imageAddress, required this.title, required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Column(
                children: [
                  Container(width: 30, height: 2, color: const Color(0xFF7BC6CC)),
                  Text(
                    "0$index",
                    style: GoogleFonts.poppins().copyWith(fontSize: 24, fontWeight: FontWeight.w400, color: const Color(0xFF7BC6CC)),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.poppins().copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
            color: const Color(0xFFF6F6F6),
            child: Image.asset(imageAddress, fit: BoxFit.fill),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
