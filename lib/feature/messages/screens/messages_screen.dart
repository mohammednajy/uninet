import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/utils/constant.dart';
import '../../community/screens/community_screen.dart';
import 'inbox_message_screen.dart';
import 'requests_message_screen.dart';

class MessagesScreen extends HookConsumerWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenIndex = useState(0);
    return Scaffold(
      appBar: const MainAppBarWidget(title: 'Message'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: () {
                        screenIndex.value = 0;
                      },
                      style: screenIndex.value != 0
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              elevation: 0,
                            )
                          : null,
                      child: Text(
                        'Inbox',
                        style: TextStyle(
                            color: screenIndex.value != 0
                                ? Colors.black
                                : Colors.white),
                      ),
                    )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    flex: 3,
                    child: ElevatedButton(
                        onPressed: () {
                          screenIndex.value = 1;
                        },
                        style: screenIndex.value != 1
                            ? ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                                elevation: 0,
                              )
                            : null,
                        child: Text(
                          'Requests',
                          style: TextStyle(
                              color: screenIndex.value != 1
                                  ? Colors.black
                                  : Colors.white),
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      minimumSize: Size(width, 50),
                      backgroundColor: Colors.grey.shade300,
                      elevation: 0,
                      alignment: Alignment.center),
                ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            [
              const InboxMessageScreen(),
              const RequestsMessageScreen()
            ][screenIndex.value]
          ],
        ),
      ),
    );
  }
}
