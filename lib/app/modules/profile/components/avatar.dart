import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_mate/app/controllers/user_controller.dart';
import 'package:task_mate/app/data/constants/constants.dart';

class ProfileImageWidget extends StatelessWidget {
  final double? radius;
  final File? imagePicked;
  const ProfileImageWidget({super.key, this.radius, this.imagePicked});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
      if (imagePicked != null) {
        return CircleAvatar(
          radius: 50.r,
          backgroundImage: FileImage(imagePicked!),
        );
      } else if (controller.user?.profilePic.isEmpty ?? true) {
        return CircleAvatar(
          radius: radius ?? 50.r,
          backgroundImage: AssetImage(AppAssets.kPlaceholderProfile),
        );
      } else {
        return CachedNetworkImage(
          imageUrl: controller
              .user!.profilePic, // Assume ! is safe here based on your logic
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              radius: radius ?? 50.r,
              backgroundImage: imageProvider,
            );
          },
          placeholder: (context, url) {
            return CircleAvatar(
              radius: radius ?? 50.r,
              backgroundImage: AssetImage(AppAssets.kPlaceholderProfile),
            );
          },
          errorWidget: (context, url, error) {
            return CircleAvatar(
              radius: radius ?? 50.r,
              backgroundImage: AssetImage(AppAssets.kPlaceholderProfile),
            );
          },
        );
      }
    });
  }
}
