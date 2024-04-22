// ignore_for_file: prefer_null_aware_operators

import 'package:flutter/material.dart';
import 'package:uninet/feature/verification/widgets/upload_file_widget.dart';
import 'package:uninet/feature/widgets/bottom_sheet_template_widget.dart';
import 'package:uninet/feature/widgets/textField_widget.dart';
import 'package:uninet/utils/extensions.dart';
import 'package:uninet/utils/validation.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  DateTime? selectedDate;
  int? groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Complete your Profile',
                    style: context.style.headlineLarge,
                  ),
                  Text(
                    'Please fill the following information to complete your profile',
                    style: context.style.headlineMedium!.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  UploadFileButtonWidget(
                    title: 'Upload Picture',
                    icon: Icons.image,
                    height: 100,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          barrierColor: Colors.grey,
                          constraints:
                              const BoxConstraints.tightFor(height: 200),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          builder: (context) {
                            return const BottomSheetTemplateWidget(
                              title: 'Upload Profile Picture',
                              widget: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                      child: UploadFileButtonWidget(
                                          icon: Icons.image,
                                          height: 100,
                                          title: 'From Gallery')),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: UploadFileButtonWidget(
                                          icon: Icons.camera_enhance,
                                          height: 100,
                                          title: 'Take Picture')),
                                ],
                              ),
                            );
                          });
                    },
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: '@a.b',
                    labelText: 'Username',
                    validator: (value) => value!.isValidName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: 'Superman',
                    labelText: 'Display Name',
                    validator: (value) => value!.isValidName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          hintText: 'Jamaal',
                          labelText: 'First Name',
                          validator: (value) => value!.isValidName,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFieldWidget(
                          hintText: 'Williams',
                          labelText: 'Last Name',
                          validator: (value) => value!.isValidName,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: '',
                    labelText: 'Bio',
                    validator: (value) => value!.isValidName,
                    lines: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: 'MM/DD/YYYY',
                    labelText: 'Date of Birth',
                    validator: (value) => value!.isValidName,
                    controller: TextEditingController(
                        text: selectedDate != null
                            ? selectedDate.toString().substring(
                                0, selectedDate.toString().indexOf(" "))
                            : null),
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1000),
                          lastDate: DateTime.now());
                      if (date == null) return;

                      setState(() {
                        selectedDate = date;
                      });
                      print(selectedDate);
                    },
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Gender',
                    style: context.style.headlineMedium!.copyWith(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<int>(
                          value: 0,
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value;
                            });
                          },
                          title: const Text('Male'),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<int>(
                          value: 1,
                          groupValue: groupValue,
                          onChanged: (value) {
                            setState(() {
                              groupValue = value;
                            });
                          },
                          title: const Text('Female'),
                        ),
                      )
                    ],
                  ),
                  TextFieldWidget(
                    hintText: 'Enter Address',
                    labelText: 'Address',
                    validator: (value) => value!.isValidName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: 'Select',
                    labelText: 'Country',
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                    ),
                    readOnly: true,
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
                              title: 'Select Country',
                              widget: ListView(
                                children: List.generate(
                                    100,
                                    (index) => TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Country $index',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ))),
                              ),
                            );
                          });
                    },
                    validator: (value) => value!.isValidName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: '',
                    labelText: 'City',
                    validator: (value) => value!.isValidName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: '',
                    labelText: 'ZIP Code',
                    validator: (value) => value!.isValidName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: 'Chasing Category',
                    labelText: 'Chasing Category',
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                    ),
                    readOnly: true,
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
                                        onPressed: () {},
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
                    validator: (value) => value!.isValidName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    hintText: '',
                    labelText: 'Chasing Description',
                    validator: (value) => value!.isValidName,
                    lines: 3,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // RouteManager.goToAndRemove(RouteName.mainAppScreen);
              },
              child: const Text('Save'),
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

// DateFormat.yMd('en-IN').format(selectedDate!)
