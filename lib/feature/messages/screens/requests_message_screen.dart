import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/core/utils/extensions.dart';

class RequestsMessageScreen extends HookConsumerWidget {
  const RequestsMessageScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: FadeInRight(
        child: ListView.separated(
          itemCount: 30,
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              print('object');
            },
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        AssetPath.postImage,
                      ))),
            ),
            title: const Text(
              'Ramzi Abou Rahal',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text('I’m going for a really big discount'),
            trailing: Column(
              children: [
                Text('15 min', style: context.style.bodySmall),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(color: ColorManager.blue),
                  ),
                )
              ],
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        ),
      ),
    );
  }
}
