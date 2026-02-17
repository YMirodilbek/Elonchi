import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MeetPlaceForm extends StatelessWidget {
  final void Function(String adress) onAdressChanged;
  final void Function(bool val) onShippingChange;
  final String? region;
  final VoidCallback onRegionTap;
  final bool shipping;
  const MeetPlaceForm({
    super.key,
    required this.onAdressChanged,
    required this.onRegionTap,
    this.region,
    required this.shipping,
    required this.onShippingChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Укажите место встречи', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            'Покупатель должен понимать, где и как можно получить товар',
            style: TextStyle(color: context.color.textSub),
          ),
          const SizedBox(height: 8),
          WScaleAnimation(
            onTap: onRegionTap,
            child: Container(
              padding: .symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(borderRadius: .circular(12), color: context.color.bgelevation),
              child: Row(
                children: [
                  SvgPicture.asset(PIcons.locationIcon),
                  const SizedBox(width: 8),
                  Text(region ?? 'Выберите регион', style: TextStyle(color: context.color.textStrong)),
                  const Spacer(),
                  region != null ? SvgPicture.asset(PIcons.cancelIcon) : SvgPicture.asset(PIcons.arrowRightIcon),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: .symmetric(horizontal: 8),
            decoration: BoxDecoration(borderRadius: .circular(12), color: context.color.bgelevation),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text('Напишите адрес', style: TextStyle(fontSize: 12, color: context.color.textSoft)),
                TextField(
                  onChanged: onAdressChanged,
                  decoration: InputDecoration(border: .none),
                  style: TextStyle(color: context.color.textSub),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: .symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: .circular(12),
              border: Border.all(width: 1, color: context.color.stroke),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/shipping.png', height: 27),
                const SizedBox(width: 8),
                Text('Вы готовы доставить товар', style: TextStyle(color: context.color.textStrong)),
                Spacer(),
                Switch(
                  value: shipping,
                  onChanged: (val) {
                    onShippingChange(val);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
