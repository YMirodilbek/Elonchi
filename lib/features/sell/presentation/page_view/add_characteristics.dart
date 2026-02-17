import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/sell/domain/entities/condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ParametsForm extends StatelessWidget {
  final VoidCallback onBrandsTap;

  final String? brand;
  final void Function(Condition condition) onConditionChange;
  final Condition? condition;
  const ParametsForm({
    super.key,
    required this.condition,
    required this.onConditionChange,
    this.brand,
    required this.onBrandsTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Укажите характеристики', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('Это поможет покупателям лучше понять ваш товар', style: TextStyle(color: context.color.textSub)),
          const SizedBox(height: 24),
          Text('Состояние', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: WScaleAnimation(
                  onTap: () {
                    onConditionChange(Condition.newProduct);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(
                      color: condition == Condition.newProduct ? context.color.bgelevation : context.color.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: context.color.stroke),
                    ),
                    child: Text('Новый', style: TextStyle(color: context.color.textSoft)),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: WScaleAnimation(
                  onTap: () {
                    onConditionChange(Condition.used);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(
                      color: condition == Condition.used ? context.color.bgelevation : context.color.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: context.color.stroke),
                    ),
                    child: Text('Б/у         ', style: TextStyle(color: context.color.textSoft)),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: WScaleAnimation(
                  onTap: () {
                    onConditionChange(Condition.almostnew);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    decoration: BoxDecoration(
                      color: condition == Condition.almostnew ? context.color.bgelevation : context.color.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: context.color.stroke),
                    ),
                    child: Text('Как новый', style: TextStyle(color: context.color.textSoft)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Бренд', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          WScaleAnimation(
            onTap: onBrandsTap,
            child: Container(
              padding: .symmetric(horizontal: 8, vertical: 16),
              decoration: BoxDecoration(borderRadius: .circular(12), color: context.color.bgelevation),
              child: Row(
                children: [
                  Text(brand ?? 'Бренды', style: TextStyle(color: context.color.textStrong)),
                  const Spacer(),
                  SvgPicture.asset(brand == null ? PIcons.arrowRightIcon : PIcons.cancelIcon),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
