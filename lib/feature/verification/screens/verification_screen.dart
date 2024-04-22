import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:uninet/feature/verification/widgets/upload_file_widget.dart';
import 'package:uninet/router/routes_name.dart';
import 'package:uninet/router/routing.dart';
import 'package:uninet/utils/extensions.dart';

import '../../widgets/title_widget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(
              title: 'Verification',
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Please upload your documents',
              style: context.style.headlineMedium!.copyWith(fontSize: 14),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        RadioListTile(
                          title: const Text('Identification Card'),
                          value: 0,
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value ?? 0;
                            });
                            print(value);
                          },
                        ),
                        Visibility(
                            visible: groupValue == 0,
                            child: const UploadFileWidget()),
                        RadioListTile(
                          title: const Text('Drivers License'),
                          value: 1,
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value ?? 0;
                            });
                            print(value);
                          },
                        ),
                        Visibility(
                            visible: groupValue == 1,
                            child: const UploadFileWidget()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                RouteManager.goToAndRemove(RouteName.completeProfileScreen);
              },
              child: const Text('Next'),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Skip for now',
                    style: context.style.bodyMedium,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
