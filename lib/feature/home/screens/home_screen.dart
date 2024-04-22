import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uninet/utils/constant.dart';
import 'package:uninet/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Feed',
          style: context.style.headlineLarge,
        ),
        actions: [
          Ink(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: IconButton(
              onPressed: () async {
                const url = "whatsapp://send?phone=+972592663280";

                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw 'Could not launch $url';
                }
              },
              icon: SvgPicture.asset(AssetPath.notificationIcon),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Ink(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AssetPath.searchIcon,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
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
    );
  }
}
