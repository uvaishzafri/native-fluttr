import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/feature/search/cubit/search_cubit.dart';
import 'package:native/widget/native_dropdown.dart';
import 'package:native/widget/text/native_medium_body_text.dart';

class NeedsFilter extends StatelessWidget {
  final Map<String, String> needs;

  const NeedsFilter({super.key, required this.needs});

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit = BlocProvider.of<SearchCubit>(context);

    List<String> percentageList = ["0%", "10%", "20%", "30%", "40%", "50%", "60%", "70%", "80%", "90%", "100%"];

    return Column(children: [
      for (int index = 0; index < needs.length; index++)
        Column(children: [
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0x0C7B7B7B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          needs.keys.toList()[index],
                          style: GoogleFonts.poppins().copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: NativeDropdown(
                  onChanged: (value) {
                    cubit.updateNeed(key: needs.keys.toList()[index], value: value.first);
                  },
                  value: [needs.values.toList()[index]],
                  maxItems: 1,
                  textStyle: NativeMediumBodyText.getStyle(context),
                  items: percentageList.map((item) => DropdownMenuItem(value: item, child: Container())).toList(),
                ),
              ),
            ],
          )
        ])
    ]);
  }
}
