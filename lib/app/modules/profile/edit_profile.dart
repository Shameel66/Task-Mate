import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/controllers/user_controller.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/auth/components/auth_field.dart';
import 'package:task_mate/app/modules/profile/components/avatar.dart';
import 'package:task_mate/app/modules/widgets/buttons/primary_button.dart';
import 'package:task_mate/app/modules/widgets/dialogs/image_picker_dialog.dart';
import 'package:task_mate/app/repo/user_repo.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = Get.find<UserController>().user!;
  File? pickedFile;
  final _nameController = TextEditingController();
  final _userRepo = UserRepo();
  @override
  void initState() {
    _nameController.text = user.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: Text('Edit Profile', style: AppTypography.kSemiBold18),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 155.h,
                width: 155.w,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.expand,
                  children: [
                    ProfileImageWidget(
                      imagePicked: pickedFile,
                    ),
                    Positioned(
                        bottom: -5,
                        right: -15,
                        child: RawMaterialButton(
                          onPressed: () {
                            ImagePickerDialogBox.pickSingleImage(
                                (file) => {
                                      setState(() {
                                        pickedFile = file;
                                      })
                                    },
                                context);
                            print(pickedFile);
                          },
                          elevation: 2.0,
                          fillColor: AppColors.kWhite,
                          padding: EdgeInsets.all(10.h),
                          shape: const CircleBorder(),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: AppColors.kPrimary,
                            size: 20.h,
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Text('Name', style: AppTypography.kRegular16),
            AuthField(
              controller: _nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }

                return null;
              },
              hintText: 'Nom complet',
            ),
            SizedBox(height: 100.h),
            PrimaryButton(
                onTap: () async {
                  await _userRepo.updateName(_nameController.text);
                  if (pickedFile != null) {
                    await _userRepo.updateProfilePhoto(photo: pickedFile!);
                  }
                  Fluttertoast.showToast(msg: 'Profile updated');
                  Get.find<UserController>().update();
                  Get.back();
                },
                text: "Save Changes")
          ],
        ),
      ),
    );
  }
}
