import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/sell/domain/entities/sell_method.dart';
import 'package:flutter/material.dart';

class RequirementsForm extends StatelessWidget {
  final void Function(String moneyType) onMoneyTypeChange;
  final String moneyType;
  final void Function(String value) onPriceChanged;
  final SellMethod sellMethod;
  final void Function(SellMethod method) onMethodChange;
  const RequirementsForm({
    super.key,
    required this.moneyType,
    required this.sellMethod,
    required this.onPriceChanged,
    required this.onMethodChange,
    required this.onMoneyTypeChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Укажите условия сделки', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text('Выберите, как вы хотите продать или отдать товар', style: TextStyle(color: context.color.textSub)),
          const SizedBox(height: 24),
          Text('Условия', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WScaleAnimation(
                onTap: () {
                  onMethodChange(SellMethod.price);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: context.color.stroke),
                    color: sellMethod == SellMethod.price ? context.color.bgelevation : context.color.background,
                  ),
                  child: Text('Указать цену', style: TextStyle(color: context.color.textSoft)),
                ),
              ),
              WScaleAnimation(
                onTap: () {
                  onMethodChange(SellMethod.exchange);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    color: sellMethod == SellMethod.exchange ? context.color.bgelevation : context.color.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: context.color.stroke),
                  ),
                  child: Text('Обмен         ', style: TextStyle(color: context.color.textSoft)),
                ),
              ),
              WScaleAnimation(
                onTap: () {
                  onMethodChange(SellMethod.giveAway);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    color: sellMethod == SellMethod.giveAway ? context.color.bgelevation : context.color.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: context.color.stroke),
                  ),
                  child: Text('Отдам даром', style: TextStyle(color: context.color.textSoft)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          if (sellMethod == SellMethod.price) Text('Цена', style: TextStyle(color: context.color.textStrong)),
          if (sellMethod == SellMethod.price) const SizedBox(height: 8),
          if (sellMethod == SellMethod.price)
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: context.color.stroke),
                      color: context.color.bgelevation,
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        onPriceChanged(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: .symmetric(horizontal: 12, vertical: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                WScaleAnimation(
                  onTap: () {
                    onMoneyTypeChange("UZS");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: context.color.stroke),
                      color: moneyType == "UZS" ? context.color.bgelevation : context.color.background,
                    ),
                    child: Text('Сум', style: TextStyle(color: context.color.textStrong)),
                  ),
                ),
                const SizedBox(width: 8),
                WScaleAnimation(
                  onTap: () {
                    onMoneyTypeChange("USD");
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: context.color.stroke),
                      color: moneyType == "USD" ? context.color.bgelevation : context.color.background,
                    ),
                    child: Text('\$', style: TextStyle(color: context.color.textStrong)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
