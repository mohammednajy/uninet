import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/widgets/decorated_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: context.style.headlineLarge,
        ),
        actions: [
          DecoratedButton(
            path: AssetPath.notificationIcon,
            onPressed: () {
              print('object');
            },
          ),
          const SizedBox(
            width: 10,
          ),
          DecoratedButton(
              path: AssetPath.settingsIcon,
              onPressed: () {
                print('object');
              }),
          const SizedBox(
            width: 10,
          ),
        ],
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
                  onPressed: () {},
                  child: Text(
                    'Wall',
                    style: context.style.labelSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Media',
                    style: context.style.labelSmall,
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Likes',
                    style: context.style.labelSmall,
                  )),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.grey,
                        ),
                      ),
                      title: const Text('Mohammed naji'),
                      subtitle: const Text('23 min'),
                      trailing: PopupMenuButton<int>(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 0,
                            child: Text('Edit your post'),
                          ),
                          const PopupMenuDivider(
                            height: 15,
                          ),
                          const PopupMenuItem(
                            value: 1,
                            child: Text('Delete your post'),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 190,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      AssetPath.postImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetPath.likeIcon),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('1.6K')
                            ],
                          )),
                      InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetPath.commentIcon),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('900')
                            ],
                          )),
                      InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetPath.retweetIcon),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('100')
                            ],
                          )),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(AssetPath.shareIcon),
                      )
                    ],
                  ),
                ],
              ),
              itemCount: 15,
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
