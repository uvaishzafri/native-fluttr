import 'package:auto_route/auto_route.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
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
            successState: (_) {
              if (context.loaderOverlay.visible) {
                context.loaderOverlay.hide();
              }
            },
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
                      tabs: const [Tab(text: 'From you'), Tab(text: 'From others')],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: TabBarView(
                      children: [
                        (state.likes.fromMe?.length ?? 0) > 0
                            ? GroupedListView<LikedUser, DateTime>(
                                elements: state.likes.fromMe!,
                                order: GroupedListOrder.DESC,
                                groupBy: groupLikeList,
                                // padding: EdgeInsets.only(right: 4),
                                groupSeparatorBuilder: (value) => NativeMediumTitleText(groupHeaderText(value)),
                                // NativeMediumTitleText(DateFormat('dd-MMM-yyyy').format(value)),
                                itemBuilder: (context, element) => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    // backgroundImage: AssetImage(element.photoURL),
                                    backgroundImage: CachedNetworkImageProvider(element.user!.photoURL!),
                                  ),
                                  title: Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(maxWidth: 100),
                                        child: Text(
                                          '${element.user!.displayName}',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                height: 22 / 12,
                                              ),
                                        ),
                                      ),
                                      NativeSmallBodyText(
                                        ', ${DateTime.tryParse(element.user!.customClaims!.birthday!)?.ageFromDate()}',
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
                                order: GroupedListOrder.DESC,
                                groupBy: groupLikeList,
                                // padding: EdgeInsets.only(right: 4),
                                groupSeparatorBuilder: (value) => NativeMediumTitleText(groupHeaderText(value)),
                                // groupSeparatorBuilder: (value) => NativeMediumTitleText(value),
                                // NativeMediumTitleText(DateFormat('dd-MMM-yyyy').format(value)),
                                itemBuilder: (context, element) => ListTile(
                                  onTap: () => context.router.push(NativeCardDetailsRoute(user: element.user!)),
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    // backgroundImage: AssetImage(element.imageUrl),
                                    backgroundImage: CachedNetworkImageProvider(element.user!.photoURL!),
                                  ),
                                  title: Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(maxWidth: 100),
                                        child: Text(
                                          '${element.user!.displayName}',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                height: 22 / 12,
                                              ),
                                        ),
                                      ),
                                      NativeSmallBodyText(
                                        ', ${DateTime.tryParse(element.user!.customClaims!.birthday!)?.ageFromDate()}',
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
              ),
            );
          } else if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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

  DateTime groupLikeList(LikedUser element) {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime thisWeek = today.subtract(Duration(days: today.weekday));

    DateTime lastWeek = thisWeek.subtract(const Duration(days: 7));
    DateTime thisMonth = DateTime(today.year, today.month, 1);
    DateTime lastMonth = DateTime(today.year, today.month - 1, 1);
    return element.updatedAt!.isAfter(today)
        ? today
        : element.updatedAt!.isAfter(yesterday)
            ? yesterday
            : element.updatedAt!.isAfter(thisWeek)
                ? thisWeek
                : element.updatedAt!.isAfter(lastWeek)
                    ? lastWeek
                    : element.updatedAt!.isAfter(thisMonth)
                        ? thisMonth
                        : element.updatedAt!.isAfter(lastMonth)
                            ? lastMonth
                            : DateTime(1900);
  }

  String groupHeaderText(DateTime dateTime) {
    var now = DateTime.now();
    var today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime thisWeek = today.subtract(Duration(days: today.weekday));

    DateTime lastWeek = thisWeek.subtract(const Duration(days: 7));
    DateTime thisMonth = DateTime(today.year, today.month, 1);
    DateTime lastMonth = DateTime(today.year, today.month - 1, 1);
    return dateTime == today
        ? 'Today'
        : dateTime == yesterday
            ? 'Yesterday'
            : dateTime == thisWeek
                ? 'This Week'
                : dateTime == lastWeek
                    ? 'Last Week'
                    : dateTime == thisMonth
                        ? 'This Month'
                        : dateTime == lastMonth
                            ? 'Last Month'
                            : 'Earlier';
  }
}
