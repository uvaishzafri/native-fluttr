import 'package:auto_route/auto_route.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/dummy_data.dart';
import 'package:native/feature/chat/cubit/chat_cubit.dart';
import 'package:native/model/native_type.dart';
import 'package:native/model/user.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/text/native_medium_title_text.dart';
import 'package:native/widget/text/native_small_body_text.dart';
import 'package:native/util/datetime_extension.dart';

@RoutePage()
class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  // List<ChatRoom> _chats = [];
  // TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    // _searchController = TextEditingController();
  }

  @override
  void dispose() {
    // _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = BlocProvider<ChatCubit>.value(
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
            // chatCreated: (value) {},
            chatRoomsFetched: (_) {},
            // chatMessagesFetched: (_) {},
            // chatMessageCreated: (value) {},
          );
        },
        builder: (context, state) {
          // final chatCubit = BlocProvider.of<ChatCubit>(context);
          return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: ColorUtils.textLightGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: ButtonsTabBar(
                      contentPadding: EdgeInsets.symmetric(horizontal: 24),
                      backgroundColor: ColorUtils.purple,
                      unselectedBackgroundColor: Colors.transparent,
                      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorUtils.white,
                            fontWeight: FontWeight.w600,
                            height: 22 / 14,
                          ),
                      unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            height: 22 / 14,
                            color: ColorUtils.textLightGrey,
                          ),
                      borderColor: Colors.transparent,
                      unselectedBorderColor: Colors.transparent,
                      radius: 100,
                      tabs: const [
                        Tab(text: 'From you'),
                        Tab(text: 'From others')
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GroupedListView<User, DateTime>(
                          elements: [
                            usersList[0],
                            // usersList[1],
                            // usersList[2],
                          ],
                          groupBy: (element) {
                            var temp = likes.fromYou.firstWhere((ele) => element.uid == ele.userId).likedDate;
                            return temp;
                          },
                          // padding: EdgeInsets.only(right: 4),
                          groupSeparatorBuilder: (value) => NativeMediumTitleText(DateFormat('dd-MMM-yyyy').format(value)),
                          itemBuilder: (context, element) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              // backgroundImage: AssetImage(element.photoURL),
                              backgroundImage: CachedNetworkImageProvider(element.photoURL!),
                            ),
                            title: Row(
                              children: [
                                NativeSmallBodyText(
                                  '${element.displayName}, ${DateTime.tryParse(element.customClaims!.birthday!)?.ageFromDate()}',
                                  fontWeight: FontWeight.w500,
                                  height: 22 / 12,
                                ),
                                Spacer(),
                                NativeSmallBodyText(
                                  '⚡️ ${element.native!.energyScore} native score',
                                  height: 22 / 12,
                                )
                              ],
                            ),
                            subtitle: NativeSmallBodyText(
                              element.customClaims!.location!,
                              height: 22 / 12,
                            ),
                          ),
                        ),
                        GroupedListView<User, DateTime>(
                          elements: [
                            usersList[0],
                            usersList[1],
                            usersList[2],
                          ],
                          groupBy: (element) {
                            var temp = likes.fromYou.firstWhere((ele) => element.uid == ele.userId).likedDate;
                            return temp;
                          },
                          // padding: EdgeInsets.only(right: 4),
                          groupSeparatorBuilder: (value) => NativeMediumTitleText(DateFormat('dd-MMM-yyyy').format(value)),
                          itemBuilder: (context, element) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              // backgroundImage: AssetImage(element.imageUrl),
                              backgroundImage: CachedNetworkImageProvider(element.photoURL!),
                            ),
                            title: Row(
                              children: [
                                NativeSmallBodyText(
                                  '${element.displayName}, ${DateTime.tryParse(element.customClaims!.birthday!)?.ageFromDate()}',
                                  fontWeight: FontWeight.w500,
                                  height: 22 / 12,
                                ),
                                Spacer(),
                                NativeSmallBodyText(
                                  '⚡️ ${element.native!.energyScore} native score',
                                  height: 22 / 12,
                                )
                              ],
                            ),
                            subtitle: NativeSmallBodyText(
                              element.customClaims!.location!,
                              height: 22 / 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );

    // Widget trailing = IconButton(
    //   onPressed: () {
    //     context.router.pop();
    //   },
    //   icon: const Icon(Icons.close_outlined),
    // );

    return CommonScaffoldWithPadding(
      'Likes',
      content,
      // trailing: trailing,
    );
  }
}
