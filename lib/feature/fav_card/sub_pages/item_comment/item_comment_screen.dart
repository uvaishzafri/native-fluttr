import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/feature/fav_card/models/fav_card_items/fav_card_items.dart';
import 'package:native/feature/fav_card/sub_pages/widgets/item_header.dart';
import 'package:native/widget/native_button.dart';

import '../../../../di/di.dart';
import '../../../../i18n/translations.g.dart';
import '../../../../widget/native_text_field.dart';
import 'cubit/item_comment_cubit.dart';

@RoutePage()
class ItemCommentScreen extends StatefulWidget {
  final FavCardItemModel item;

  const ItemCommentScreen({super.key, required this.item});

  @override
  State<ItemCommentScreen> createState() => _ItemCommentScreenState();
}

class _ItemCommentScreenState extends State<ItemCommentScreen> {
  final TextEditingController _controller = TextEditingController();
  final int commentMaxLength = 100;

  @override
  void initState() {
    _controller.text = widget.item.comment ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 73),
        child: BlocProvider<ItemCommentCubit>.value(
          value: getIt<ItemCommentCubit>(),
          child: BlocConsumer<ItemCommentCubit, ItemCommentState>(
              listener: (context, state) {
            state.map(
              initial: (value) {},
              loading: (value) {
                if (!context.loaderOverlay.visible) {
                  context.loaderOverlay.show();
                }
              },
              error: (value) {
                if (context.loaderOverlay.visible) {
                  context.loaderOverlay.hide();
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(value.appException.message),
                  backgroundColor: const Color(0xFFFF0000),
                ));
              },
              success: (value) {
                if (context.loaderOverlay.visible) {
                  context.loaderOverlay.hide();
                }
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(t.strings.favCardLikeSent),
                  backgroundColor: const Color(0xFF03C94F),
                ));
                Navigator.of(context).pop();
              },
            );
          }, builder: (context, state) {
            final itemCommentCubit = BlocProvider.of<ItemCommentCubit>(context);
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 48,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                      Icons.arrow_back_ios_new_outlined),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  t.strings.chooseYourInterest,
                                  style: GoogleFonts.poppins().copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 34),
                        ItemHeader(
                          item: widget.item,
                          clickAble: false,
                          noOfLikedCards: 0,
                        ),
                        const SizedBox(height: 27),
                        NativeTextField(_controller,
                            maxLines: 8,
                            maxLength: commentMaxLength,
                            hintText: t.strings.favCardDescription),
                        const SizedBox(height: 200),
                      ]),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: NativeButton(
                        isEnabled: true,
                        text: t.strings.save,
                        onPressed: () => itemCommentCubit.likeFavCard(
                            favCardId: widget.item.id,
                            comment: _controller.text),
                      ),
                    ))
              ],
            );
          }),
        ),
      ),
    );
  }
}
