import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/core/router/routes_name.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/community/screens/community_screen.dart';
import 'package:uninet/feature/profile/screens/likes_screen.dart';
import 'package:uninet/feature/profile/screens/media_screen.dart';
import 'package:uninet/feature/profile/screens/wall_screen.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScreen = useState(0);
    return Scaffold(
      appBar: MainAppBarWidget(
        title: 'Profile',
        onPressedNotification: () {},
        onPressedRight: () {
          RouteManager.pushNamed(RouteName.settingsScreen);
        },
        iconPath: AssetPath.settingsIcon,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Ramzi Abou Rahal',
                          style: context.style.headlineLarge!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text('Posts'),
                              Text('200'),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Followers'),
                              Text('20K'),
                            ],
                          ),
                          Column(
                            children: [
                              Text('following'),
                              Text('120'),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    selectedScreen.value = 0;
                  },
                  child: Text(
                    'Wall',
                    style: context.style.labelSmall!.copyWith(
                      fontWeight: selectedScreen.value == 0
                          ? FontWeight.bold
                          : FontWeight.w400,
                      color: selectedScreen.value == 0
                          ? ColorManager.blue
                          : Colors.grey,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    selectedScreen.value = 1;
                  },
                  child: Text(
                    'Media',
                    style: context.style.labelSmall!.copyWith(
                      fontWeight: selectedScreen.value == 1
                          ? FontWeight.bold
                          : FontWeight.w400,
                      color: selectedScreen.value == 1
                          ? ColorManager.blue
                          : Colors.grey,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    selectedScreen.value = 2;
                  },
                  child: Text(
                    'Likes',
                    style: context.style.labelSmall!.copyWith(
                      fontWeight: selectedScreen.value == 2
                          ? FontWeight.bold
                          : FontWeight.w400,
                      color: selectedScreen.value == 2
                          ? ColorManager.blue
                          : Colors.grey,
                    ),
                  )),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          [
            const WallScreen(),
            const MediaScreen(),
            const LikesScreen()
          ][selectedScreen.value]
        ],
      ),
    );
  }
}
