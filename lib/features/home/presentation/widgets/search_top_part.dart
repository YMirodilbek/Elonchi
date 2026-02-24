import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchTopPart extends StatelessWidget {
  final TextEditingController? searchController;
  final void Function(String value) onSearch;
  final VoidCallback onBackTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onFiltersTap;
  final bool showDeleteIcon;
  const SearchTopPart({
    super.key,
    this.searchController,
    required this.onBackTap,
    required this.onDeleteTap,
    required this.onFiltersTap,
    required this.onSearch,
    required this.showDeleteIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WScaleAnimation(
          onTap: onBackTap,
          child: SvgPicture.asset(PIcons.arrowLeftIcon, color: context.color.iconStrong),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: context.color.bgelevation, borderRadius: BorderRadius.circular(16)),
            child: TextField(
              controller: searchController,
              onChanged: onSearch,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Padding(padding: const EdgeInsets.all(10.0), child: SvgPicture.asset(PIcons.searchIcon)),
                suffixIcon: showDeleteIcon
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: WScaleAnimation(onTap: onDeleteTap, child: SvgPicture.asset(PIcons.deleteTextIcon)),
                      )
                    : null,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        WScaleAnimation(
          onTap: onFiltersTap,
          child: SvgPicture.asset(PIcons.filtersIcon, color: context.color.iconStrong),
        ),
      ],
    );
  }
}
