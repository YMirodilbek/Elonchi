import 'package:cached_network_image/cached_network_image.dart';
import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/features/profile/data/user_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserInfo extends StatelessWidget {
  final int? selectedImgIndex;
  final UserModel userModel;
  const UserInfo({super.key, required this.userModel, required this.selectedImgIndex});

  @override
  Widget build(BuildContext context) {
    final String imagePath = userModel.image ?? "";
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.color.bgelevation),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: context.color.background,
            child: imagePath.isNotEmpty
                ? ClipOval(
                    child: CachedNetworkImage(imageUrl: imagePath, width: 64, height: 64, fit: BoxFit.cover),
                  )
                : selectedImgIndex != null
                ? Image.asset('assets/images/img$selectedImgIndex.png', width: 64, height: 64, fit: BoxFit.cover)
                : SvgPicture.asset(PIcons.userProfileIcon),
          ),
          const SizedBox(height: 8),
          (userModel.firstName == null || userModel.firstName!.isEmpty)
              ? Text(
                  "profile.enter_name".tr(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.base),
                )
              : Text(
                  userModel.firstName ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textStrong),
                ),
          const SizedBox(height: 4),
          // here
          Text("profile.created".tr(), style: TextStyle(color: context.color.text400, fontSize: 12)),
        ],
      ),
    );
  }
}
