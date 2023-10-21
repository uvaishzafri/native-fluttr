import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/dummy_data.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/chat/cubit/chat_cubit.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/like_overlay.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_card.dart';

@RoutePage()
class ChoosePartnerScreen extends StatelessWidget {
  const ChoosePartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtils.white,
        body: BlocProvider<ChatCubit>.value(
          value: getIt<ChatCubit>(),
          child: BlocConsumer<ChatCubit, ChatState>(
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
                  ));
                },
                // chatCreated: (value) {
                //   if (context.loaderOverlay.visible) {
                //     context.loaderOverlay.hide();
                //   }
                //   context.router.push(const HomeWrapperRoute());
                // },
                chatRoomsFetched: (_) {},
                // chatMessagesFetched: (_) {},
                // chatMessageCreated: (value) {},
              );
            },
            builder: (context, state) {
              // final chatCubit = BlocProvider.of<ChatCubit>(context);
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/home/ic_logo_black.svg',
                        ),
                        // Image.asset('assets/ic_logo_light.png'),
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            text: 'Choose a partner to view and ',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: ColorUtils.textGrey,
                                  height: 30 / 16,
                                ),
                            children: [
                              TextSpan(
                                text: 'LIKE',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: ColorUtils.purple,
                                      height: 30 / 16,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                            child: CustomScrollView(
                          slivers: [
                            _recommendations(/*chatCubit*/),
                          ],
                        )),
                        // _recommendations(),
                      ],
                    ),
                  ),
                  const Positioned(
                    bottom: 100,
                    left: 100,
                    child: Icon(
                      Icons.touch_app_outlined,
                      size: 80,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _recommendations(/*ChatCubit chatCubit*/) {
    return SliverGrid.builder(
      // padding: const EdgeInsets.all(8),
      itemCount: usersList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            var overlayItem = LikeOverlay(
              onPressedLike: () {
                showDialog(
                            context: context,
                            builder: (context) => likeDialog(context /*chatCubit*/),
                );
              },
              isTutorial: true,
            );
            context.router.push(NativeCardScaffold(user: usersList[index], overlayItem: overlayItem, isDemoUser: true));
          },
          child: NativeUserCard(
            native: usersList[index],
          ),
        );
      },
    );
  }

  Widget likeDialog(BuildContext context /*, ChatCubit chatCubit*/) {
    return AlertDialog(
      backgroundColor: ColorUtils.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: 'All you do is send a ',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: ColorUtils.textGrey,
                    height: 22 / 14,
                  ),
              children: [
                TextSpan(
                  text: 'LIKE',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorUtils.purple,
                        fontWeight: FontWeight.w700,
                        height: 22 / 14,
                      ),
                ),
                TextSpan(
                  text: ' to get matched',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorUtils.textGrey,
                        height: 22 / 14,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 330,
                height: 330,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorUtils.aquaGreen.withOpacity(0.6),
                ),
              ),
              Container(
                width: 256,
                height: 256,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorUtils.aquaGreen.withOpacity(0.6),
                ),
              ),
              Container(
                width: 186,
                height: 186,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorUtils.aquaGreen.withOpacity(0.6),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/home/ic_test.png'),
                  ),
                  SizedBox(width: 24),
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: ColorUtils.purple,
                    size: 37,
                  ),
                  SizedBox(width: 24),
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/home/ic_profile_pic2.png'),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      actions: [
        NativeButton(
          isEnabled: true,
          onPressed: () {
            context.router.pop();
            //TODO update this
            // var chat = dummyChatList[0];
            // chatCubit.createSingleChatRoom(chat);
          },
          text: "Let's go",
        )
      ],
    );
  }
}
