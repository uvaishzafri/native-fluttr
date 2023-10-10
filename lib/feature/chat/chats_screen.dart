import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:native/repo/model/chat.dart';
import 'package:native/util/color_utils.dart';
import 'package:native/widget/common_scaffold.dart';
import 'package:native/widget/common_scaffold_with_padding.dart';
import 'package:native/widget/native_button.dart';
import 'package:native/widget/native_text_field.dart';
import 'package:native/widget/text/native_large_body_text.dart';
import 'package:native/widget/text/native_large_title_text.dart';
import 'package:native/widget/text/native_medium_body_text.dart';
import 'package:native/widget/text/native_medium_title_text.dart';

@RoutePage()
class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  List<Chat> _chats = [];
  TextEditingController? _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _emptyChatWidget() {
      return Column(
        children: [
          SvgPicture.asset('assets/chat/empty_chat.svg'),
          NativeLargeTitleText(
            'There is no talk yet',
            fontWeight: FontWeight.w500,
          ),
          NativeLargeBodyText('If you want to start falling in love, start with a chat'),
          const SizedBox(height: 30),
          NativeButton(
            isEnabled: true,
            text: 'Find your partner',
            onPressed: () {
              // context.router.push(const );
            },
          ),
          const SizedBox(height: 30),
        ],
      );
    }

    Widget _searchBar() {
      return NativeTextField(_searchController, hintText: 'Search', prefixIcon: const Icon(Icons.search, color: Color(0x321E1E1E)));
    }

    Widget content = _chats.isEmpty
        ? _emptyChatWidget()
        : Column(
            children: [
              _searchBar(),
              NativeMediumTitleText('Recent chats'),
              Expanded(
                  child: ListView.builder(
                itemCount: _chats.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.lorem/2'),
                    ),
                    // title: ,
                    // subtitle: ,
                  );
                },
              )),
              SvgPicture.asset('assets/playing_cards.svg'),
              const SizedBox(height: 20),
              Container(
                color: ColorUtils.purple,
                child: const NativeMediumTitleText(
                  'Subscribers get more benefits',
                  color: ColorUtils.white,
                ),
              ),
              Table(
                children: const [
                  TableRow(children: [
                    SizedBox(),
                    Column(
                      children: [
                        NativeMediumTitleText(
                          'native.',
                          color: ColorUtils.purple,
                        ),
                        NativeMediumBodyText('Free')
                      ],
                    ),
                    Column(
                      children: [
                        NativeMediumTitleText(
                          'native.',
                          color: ColorUtils.purple,
                        ),
                        NativeMediumBodyText('Plus')
                      ],
                    ),
                  ]),
                  TableRow(children: [
                    NativeLargeBodyText('Likes'),
                    NativeMediumBodyText('30'),
                    NativeMediumBodyText('Unlimited'),
                  ]),
                  TableRow(children: [
                    NativeLargeBodyText('See everyone who likes you'),
                    Icon(Icons.close),
                    Icon(Icons.check),
                  ]),
                  TableRow(children: [
                    NativeLargeBodyText('native. card based search'),
                    Icon(Icons.close),
                    Icon(Icons.check),
                  ]),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Launching soon!',
                style: TextStyle(color: ColorUtils.purple, fontSize: 18, fontWeight: FontWeight.w600, height: 22 / 18),
              )
            ],
          );

    // Widget trailing = IconButton(
    //   onPressed: () {
    //     context.router.pop();
    //   },
    //   icon: const Icon(Icons.close_outlined),
    // );

    return CommonScaffoldWithPadding(
      'Chats',
      content,
      // trailing: trailing,
    );
  }
}
