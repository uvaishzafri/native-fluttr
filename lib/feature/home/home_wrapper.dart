import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/widget/images.dart';

const _assetFolder = 'assets/home';

@RoutePage()
class HomeWrapperScreen extends StatefulWidget {
  const HomeWrapperScreen({Key? key}) : super(key: key);
  @override
  State<HomeWrapperScreen> createState() => _HomeWrapperScreenState();
}

class _HomeWrapperScreenState extends State<HomeWrapperScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        const HomeRoute(),
        OnboardingRoute(),
        const SignInRoute(),
        const SignUpRoute(),
        const AccountRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home_filled),
                    label: 'Home'),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  activeIcon: Icon(Icons.favorite),
                  label: 'Likes',
                ),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_outlined),
                    activeIcon: Icon(Icons.notifications),
                    label: 'Notification'),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.chat_outlined),
                  activeIcon: Icon(Icons.chat),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: NativeHeadImage(
                    Image.asset("$_assetFolder/ic_test.png"),
                    borderColor: Theme.of(context).colorScheme.primary,
                    radius: 14,
                    borderRadius: 2,
                    isGradientBorder: false,
                  ),
                  label: 'Account',
                ),
              ],
              type: BottomNavigationBarType.fixed,
            ));
      },
    );
  }
}
