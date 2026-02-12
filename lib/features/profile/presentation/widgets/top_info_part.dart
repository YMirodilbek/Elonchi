import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/profile/data/user_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopInfoPart extends StatelessWidget {
  final int? selectedImageIndex;
  final VoidCallback onImageAddTap;
  final UserModel userModel;
  const TopInfoPart({super.key, required this.userModel, required this.onImageAddTap, this.selectedImageIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(color: context.color.bgelevation, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: context.color.white, borderRadius: BorderRadius.circular(12)),
            padding: selectedImageIndex != null ? null : const EdgeInsets.all(12),
            child: WScaleAnimation(
              onTap: onImageAddTap,
              child: selectedImageIndex != null
                  ? Image.asset('assets/images/img$selectedImageIndex.png')
                  : SvgPicture.asset(PIcons.imageAddIcon),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userModel.firstName ?? '', style: TextStyle(color: context.color.textStrong)),
              const SizedBox(height: 4),
              Text('Профель создань 14.01.2026', style: TextStyle(color: context.color.textSoft, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
