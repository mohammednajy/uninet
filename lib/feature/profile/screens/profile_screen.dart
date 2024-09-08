import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/feature/auth/provider/get_user_provider.dart';
import '../../../core/router/routes_name.dart';
import '../../../core/router/routing.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extensions.dart';
import '../../community/screens/community_screen.dart';
import 'likes_screen.dart';
import 'media_screen.dart';
import 'wall_screen.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider);
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
      body: user.when(data: (data) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 80,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: data.image != null
                          ? Image.network(
                              data.image!,
                              fit: BoxFit.fill,
                            )
                          : Icon(
                              Icons.person,
                              size: 30,
                            ),
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
                            data.userName ?? '',
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
                                Text('Following'),
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
        );
      }, error: (error, _) {
        return Text(error.toString());
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }),
    );
  }
}
