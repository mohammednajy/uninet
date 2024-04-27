import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uninet/core/router/routes_name.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/feature/home/screens/home_screen.dart';
import 'package:uninet/core/utils/constant.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  static const List<String> iconPath = [
    AssetPath.homeIcon,
    AssetPath.communityIcon,
    AssetPath.chatIcon,
    AssetPath.chatIcon,
  ];
  int selectedIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    print('userData ${FirebaseAuth.instance.currentUser} ');
    return Scaffold(
      body: screens[0],
      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, -3),
              blurRadius: 5,
              spreadRadius: 0.5,
            )
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            4,
            (index) {
              return Row(
                children: [
                  if (index == 2)
                    const SizedBox(
                      width: 35,
                    ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 8,
                          width: 15,
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.black
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        index == 3
                            ? const CircleAvatar(
                                radius: 12,
                              )
                            : SvgPicture.asset(iconPath[index],
                                colorFilter: index == selectedIndex
                                    ? const ColorFilter.mode(
                                        Colors
                                            .black, // Replace with the color you want
                                        BlendMode.srcIn,
                                      )
                                    : null),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          RouteManager.pushNamed(RouteName.createNewPostScreen);
        },
        child: Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: ColorManager.blue,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue.shade200,
              width: 5,
            ),
          ),
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
