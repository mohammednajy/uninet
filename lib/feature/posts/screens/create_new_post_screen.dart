import 'package:flutter/material.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/feature/widgets/bottom_sheet_template_widget.dart';
import 'package:uninet/feature/widgets/headline_appbar.dart';

class CreateNewPostScreen extends StatefulWidget {
  const CreateNewPostScreen({super.key});

  @override
  State<CreateNewPostScreen> createState() => _CreateNewPostScreenState();
}

class _CreateNewPostScreenState extends State<CreateNewPostScreen> {
  String? chasingCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeadlineAppBar(title: 'New Post'),
      body: ListView(
        children: [
          const Divider(
            thickness: 1,
          ),
          TextField(
            maxLines: 6,
            minLines: 6,
            decoration: InputDecoration(
              hintText: 'Tell your audience more..',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            height: 25,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.grey,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  builder: (context) {
                    return BottomSheetTemplateWidget(
                      title: 'Select Chasing Category',
                      widget: ListView(
                        children: List.generate(
                            5,
                            (index) => TextButton(
                                onPressed: () {
                                  setState(() {
                                    chasingCategory = 'Chasing $index';
                                  });
                                  RouteManager.pop();
                                },
                                child: Text(
                                  'Chasing $index',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ))),
                      ),
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chasing',
                    style: context.style.headlineMedium!.copyWith(fontSize: 14),
                  ),
                  const Icon(
                    Icons.arrow_right,
                    size: 35,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 70,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: 70,
                    width: 80,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            AssetPath.postImage,
                          ),
                          fit: BoxFit.fill),
                    ),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                  );
                }),
          ),
          const Divider(
            thickness: 1,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  print('add image');
                },
                icon: const Icon(
                  Icons.image,
                  color: ColorManager.blue,
                  size: 40,
                ),
                padding: const EdgeInsets.only(left: 10),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(100, 40)),
                child: const Text('Post'),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          )
        ],
      ),
    );
  }
}
