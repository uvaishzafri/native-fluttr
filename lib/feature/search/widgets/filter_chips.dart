import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterChips extends StatelessWidget {
  final String item;
  final VoidCallback onPressed;

  const FilterChips({super.key, required this.item, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 20,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFBE94C6)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item,
                  style: GoogleFonts.poppins().copyWith(fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xFFBE94C6)),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: onPressed,
                  child: const Icon(
                    Icons.close_outlined,
                    size: 14,
                    color: Color(0xFFBE94C6),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
