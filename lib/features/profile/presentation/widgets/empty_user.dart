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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: context.color.bgelevation),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: context.color.background,
            child: selectedImgIndex != null
                ? Image.asset('assets/images/img$selectedImgIndex.png')
                : SvgPicture.asset(PIcons.userProfileIcon),
          ),
          const SizedBox(height: 8),
          (userModel.firstName == null || userModel.firstName!.isEmpty)
              ? Text(
                  "Напишите свой имя",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.base),
                )
              : Text(
                  userModel.firstName ?? '',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textStrong),
                ),
          const SizedBox(height: 4),
          Text("Профель создань 14.01.2026", style: TextStyle(color: context.color.text400, fontSize: 12)),
        ],
      ),
    );
  }
}
