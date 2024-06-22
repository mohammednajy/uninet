import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uninet/core/router/routes_name.dart';
import 'package:uninet/core/utils/constant.dart';
import 'package:uninet/feature/auth/models/user_model.dart';
import 'package:uninet/feature/profile/providers/complete_profile_provider.dart';
import 'package:uninet/feature/verification/widgets/upload_file_widget.dart';
import 'package:uninet/feature/widgets/bottom_sheet_template_widget.dart';
import 'package:uninet/feature/widgets/headline_appbar.dart';
import 'package:uninet/feature/widgets/loading_widget.dart';
import 'package:uninet/feature/widgets/snackbar_widget.dart';
import 'package:uninet/feature/widgets/textField_widget.dart';
import 'package:uninet/core/router/routing.dart';
import 'package:uninet/core/utils/extensions.dart';
import 'package:uninet/core/utils/validation.dart';

class CompleteProfileScreen extends HookConsumerWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final userName = useTextEditingController();
    final displayName = useTextEditingController();
    final firstName = useTextEditingController();
    final lastName = useTextEditingController();
    final bio = useTextEditingController();
    final address = useTextEditingController();
    final city = useTextEditingController();
    final zipCode = useTextEditingController();
    final chasingDescription = useTextEditingController();
    final selectedDate = useState<DateTime?>(null);
    final groupValue = useState<int?>(0);
    final country = useState<String?>(null);
    final chasingCategory = useState<String?>(null);
    final pickImageProfile = ref.watch(pickImageProfileProvider);
    // final completeProfile = ref.watch(completeProfileProvider);
    final uploadImage = ref.watch(profileUploadImageProvider);

    ref.listen(profileUploadImageProvider, (prev, next) {
      next.when(data: (url) {
        Navigator.pop(context);
        showSnackBarCustom(
            text: 'uploaded successfully', backgroundColor: Colors.green);
      }, error: (e, _) {
        Navigator.pop(context);
        showSnackBarCustom(text: e.toString());
      }, loading: () {
        loadingWithText();
      });
    });

    ref.listen(pickImageProfileProvider, (prev, next) {
      next.whenData((data) {
        if (data != null) {
          ref
              .read(profileUploadImageProvider.notifier)
              .uploadImage(image: data);
          print('there is data');
        }
      });
    });
    ref.listen(completeProfileProvider, (prev, next) {
      next.when(data: (value) {
        Navigator.pop(context);
        RouteManager.goToAndRemove(RouteName.mainAppScreen);
        showSnackBarCustom(
            text: 'Data Saved successfully', backgroundColor: Colors.green);
      }, error: (e, _) {
        Navigator.pop(context);
        showSnackBarCustom(text: e.toString());
      }, loading: () {
        loadingWithText();
      });
    });
    return Scaffold(
      appBar: const HeadlineAppBar(
        title: 'Complete your Profile',
        leading: false,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please fill the following information to complete your profile',
                  style: context.style.headlineMedium!.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                UploadFileButtonWidget(
                  title: 'Upload Picture',
                  image: pickImageProfile.value,
                  icon: Icons.image,
                  height: 100,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        barrierColor: Colors.grey,
                        constraints: const BoxConstraints.tightFor(height: 200),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        builder: (context) {
                          return BottomSheetTemplateWidget(
                            title: 'Upload Profile Picture',
                            widget: Row(
                              children: [
                                Expanded(
                                    child: UploadFileButtonWidget(
                                        onTap: () {
                                          Navigator.pop(context);
                                          ref
                                              .read(pickImageProfileProvider
                                                  .notifier)
                                              .pickImageFromBack(
                                                  source: ImageSource.gallery);
                                        },
                                        icon: Icons.image,
                                        height: 100,
                                        title: 'From Gallery')),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: UploadFileButtonWidget(
                                        onTap: () {
                                          Navigator.pop(context);
                                          ref
                                              .read(pickImageProfileProvider
                                                  .notifier)
                                              .pickImageFromBack(
                                                  source: ImageSource.camera);
                                        },
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
                  hintText: 'mohammed_naji',
                  labelText: 'Username',
                  validator: (value) => value!.isValidUsername,
                  controller: userName,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  hintText: 'Superman',
                  labelText: 'Display Name',
                  validator: (value) => value!.isValidField,
                  controller: displayName,
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
                        validator: (value) => value!.isValidField,
                        controller: firstName,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFieldWidget(
                        hintText: 'Williams',
                        labelText: 'Last Name',
                        validator: (value) => value!.isValidField,
                        controller: lastName,
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
                  validator: (value) => value!.isValidField,
                  lines: 3,
                  controller: bio,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  hintText: 'MM/DD/YYYY',
                  labelText: 'Date of Birth',
                  validator: (value) => value!.isValidField,
                  controller: TextEditingController(
                      text: selectedDate.value?.toString().substring(
                          0, selectedDate.value.toString().indexOf(" "))),
                  onTap: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1000),
                        lastDate: DateTime.now());
                    if (date == null) return;
                    selectedDate.value = date;
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
                        groupValue: groupValue.value,
                        onChanged: (value) {
                          groupValue.value = value;
                        },
                        title: const Text('Male'),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<int>(
                        value: 1,
                        groupValue: groupValue.value,
                        onChanged: (value) {
                          groupValue.value = value;
                        },
                        title: const Text('Female'),
                      ),
                    )
                  ],
                ),
                TextFieldWidget(
                  hintText: 'Enter Address',
                  labelText: 'Address',
                  validator: (value) => value!.isValidField,
                  controller: address,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  hintText: 'Select',
                  labelText: 'Country',
                  controller: TextEditingController(text: country.value),
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
                            widget: ListView.builder(
                                itemCount: countries.length,
                                itemBuilder: (context, index) => TextButton(
                                    onPressed: () {
                                      country.value = countries[index];

                                      RouteManager.pop();
                                    },
                                    child: Text(
                                      countries[index],
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ))),
                          );
                        });
                  },
                  validator: (value) => value!.isValidField,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  hintText: '',
                  labelText: 'City',
                  validator: (value) => value!.isValidField,
                  controller: city,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  hintText: '',
                  labelText: 'ZIP Code',
                  validator: (value) => value!.isValidField,
                  controller: zipCode,
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
                  controller:
                      TextEditingController(text: chasingCategory.value),
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
                              widget: ListView.builder(
                                  itemCount: chasingCategoryList.length,
                                  itemBuilder: (context, index) => TextButton(
                                      onPressed: () {
                                        chasingCategory.value =
                                            chasingCategoryList[index];

                                        RouteManager.pop();
                                      },
                                      child: Text(
                                        chasingCategoryList[index],
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ))));
                        });
                  },
                  validator: (value) => value!.isValidField,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  hintText: '',
                  labelText: 'Chasing Description',
                  validator: (value) => value!.isValidField,
                  lines: 3,
                  controller: chasingDescription,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (pickImageProfile.value != null) {
                        if (uploadImage.value != null) {
                          final user = UserModel(
                            email: '',
                            userId: '',
                            image: uploadImage.value!,
                            userName: userName.text,
                            displayName: displayName.text,
                            
                            name: '${firstName.text} ${lastName.text}',
                            bio: bio.text,
                            date: selectedDate.value.toString(),
                            gender: groupValue.value == 0 ? "Male" : "Female",
                            address: address.text,
                            country: country.value,
                            city: city.text,
                            zipCode: zipCode.text,
                            chasingCategory: chasingCategory.value,
                            chasingDescription: chasingDescription.text,
                          );
                          print(user.toMapCompleteProfile());
                          ref
                              .read(completeProfileProvider.notifier)
                              .uploadUserData(user.toMapCompleteProfile());
                        }
                      } else {
                        showSnackBarCustom(text: 'plz, pick profile image');
                      }
                    }
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        RouteManager.goToAndRemove(RouteName.mainAppScreen);
                      },
                      child: Text(
                        'Skip for now',
                        style: context.style.bodyMedium,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
