import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/data/constants/constants.dart';
import 'package:task_mate/app/modules/widgets/buttons/primary_button.dart';
import 'package:task_mate/app/service/image_picker_service.dart';

class ImagePickerDialog extends StatelessWidget {
  final VoidCallback galleryCallback;
  final VoidCallback cameraCallback;
  const ImagePickerDialog(
      {super.key, required this.galleryCallback, required this.cameraCallback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(20.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Profile Picture',
            style: AppTypography.kBold14,
          ),
          Text(
            'Choose a profile picture for your account.',
            textAlign: TextAlign.center,
            style: AppTypography.kRegular14,
          ),
          SizedBox(height: 20.h),
          PrimaryButton(onTap: galleryCallback, text: 'Gallery'),
          SizedBox(height: 10.h),
          PrimaryButton(onTap: cameraCallback, text: 'Camera'),
        ],
      ),
    );
  }
}

class ImagePickerDialogBox {
  static Future<File?> pickSingleImage(Function(File) callBack, context) async {
    File? pickedFile;
    showGeneralDialog(
      barrierLabel: 'Label',
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ImagePickerDialog(
            cameraCallback: () async {
              Navigator.pop(context);
              0.5.seconds.delay().then((value) async {
                pickedFile = await ImagePickerServices().getImageFromCamera();
                if (pickedFile != null) {
                  callBack(pickedFile!);
                  return pickedFile;
                }
              });
            },
            galleryCallback: () async {
              Navigator.pop(context);
              0.5.seconds.delay().then((value) async {
                pickedFile = await ImagePickerServices().getImageFromGallery();
                if (pickedFile != null) {
                  callBack(pickedFile!);

                  return pickedFile;
                }
              });
            },
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
    return pickedFile;
  }
}
