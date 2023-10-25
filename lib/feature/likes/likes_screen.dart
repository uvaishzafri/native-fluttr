import 'package:auto_route/auto_route.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/feature/likes/cubit/likes_cubit.dart';
import 'package:native/model/liked_user.dart';
import 'package:native/model/user.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/util/exceptions.dart';
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
    Widget content = BlocProvider<LikesCubit>.value(
      value: getIt<LikesCubit>()..fetchLikesReport(),
      child: BlocConsumer<LikesCubit, LikesState>(
        listener: (context, state) {
          state.map(
            initial: (value) {},
            loading: (value) {
              if (!context.loaderOverlay.visible) {
                context.loaderOverlay.show();
              }
            },
            errorState: (value) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
              if (value.appException is UnauthorizedException) {
                BlocProvider.of<AppCubit>(context).logout();
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.appException.message),
              ));
            },
            successState: (_) {},
          );
        },
        builder: (context, state) {
          if (state is SuccessState) {
          return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: ColorUtils.textLightGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: ButtonsTabBar(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
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
                          (state.likes.fromMe?.length ?? 0) > 0
                              ? GroupedListView<LikedUser, DateTime>(
                                  elements: state.likes.fromMe!,
                          groupBy: (element) {
                                    return element.updatedAt!;
                                    //         var temp = DateFormat('yyyy-MM-dd').format(element.updatedAt!);
                                    // return temp;
                          },
                          // padding: EdgeInsets.only(right: 4),
                          groupSeparatorBuilder: (value) => NativeMediumTitleText(DateFormat('dd-MMM-yyyy').format(value)),
                          itemBuilder: (context, element) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              // backgroundImage: AssetImage(element.photoURL),
                                      backgroundImage: CachedNetworkImageProvider(element.user!.photoURL!),
                            ),
                            title: Row(
                              children: [
                                NativeSmallBodyText(
                                          '${element.user!.displayName}, ${DateTime.tryParse(element.user!.customClaims!.birthday!)?.ageFromDate()}',
                                  fontWeight: FontWeight.w500,
                                  height: 22 / 12,
                                ),
                                        const Spacer(),
                                NativeSmallBodyText(
                                          '⚡️ ${element.user!.native!.energyScore} native score',
                                  height: 22 / 12,
                                )
                              ],
                            ),
                            subtitle: NativeSmallBodyText(
                                      element.user!.customClaims!.location!,
                              height: 22 / 12,
                            ),
                          ),
                                )
                              : const SizedBox.expand(),
                          (state.likes.toMe?.length ?? 0) > 0
                              ? GroupedListView<LikedUser, DateTime>(
                                  elements: state.likes.toMe!,
                          groupBy: (element) {
                                    return element.updatedAt!;
                                    //         var temp = DateFormat('yyyy-MM-dd').parse(element.customClaims!.birthday!);
                                    // return temp;
                          },
                          // padding: EdgeInsets.only(right: 4),
                          groupSeparatorBuilder: (value) => NativeMediumTitleText(DateFormat('dd-MMM-yyyy').format(value)),
                          itemBuilder: (context, element) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              // backgroundImage: AssetImage(element.imageUrl),
                                      backgroundImage: CachedNetworkImageProvider(element.user!.photoURL!),
                            ),
                            title: Row(
                              children: [
                                NativeSmallBodyText(
                                          '${element.user!.displayName}, ${DateTime.tryParse(element.user!.customClaims!.birthday!)?.ageFromDate()}',
                                  fontWeight: FontWeight.w500,
                                  height: 22 / 12,
                                ),
                                        const Spacer(),
                                NativeSmallBodyText(
                                          '⚡️ ${element.user!.native!.energyScore} native score',
                                  height: 22 / 12,
                                )
                              ],
                            ),
                            subtitle: NativeSmallBodyText(
                                      element.user!.customClaims!.location!,
                              height: 22 / 12,
                            ),
                          ),
                                )
                              : const SizedBox.expand(),
                      ],
                    ),
                  ),
                ],
              ));
          } else {
            return const SizedBox.expand();
          }
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
