import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native/feature/search/widgets/common_filters.dart';
import 'package:native/feature/search/widgets/native_plus_promotion.dart';
import 'package:native/i18n/translations.g.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  final bool hasActiveSubscription;

  const SearchScreen({super.key, required this.hasActiveSubscription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 73),
            child: Column(children: [
              SizedBox(
                height: 48,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        t.strings.searchBy,
                        style: GoogleFonts.poppins().copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),

              //TODO: Change it back to false
              if (hasActiveSubscription == true) const NativePlusPromotion(),
              CommonFilters(
                hasActiveSubscription: hasActiveSubscription,
              )
            ])));
  }
}
