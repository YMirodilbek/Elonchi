import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/core/widgets/cummon_textfield.dart';
import 'package:elonchi/features/home/presentation/widgets/filter_item.dart';
import 'package:elonchi/features/home/presentation/widgets/filter_top_part.dart';
import 'package:elonchi/features/home/presentation/widgets/price_filter_sheet.dart';
import 'package:elonchi/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FiltersPage extends StatefulWidget {
  const FiltersPage({super.key});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterTopPart(
                onBackTap: () {
                  context.pop();
                },
                onResetTap: () {},
              ),
              const SizedBox(height: 16),
              FilterItem(
                title: "Категория",
                iconPath: PIcons.menu2Icon,
                onTap: () {
                  context.push(Routes.categoriesScreen);
                },
                borderRadiusGeometry: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              Container(height: 1, color: Color(0xffE2E8F0)),
              FilterItem(
                title: "Сортировать по",
                iconPath: PIcons.arrorDown,
                onTap: () {
                  triggerBottomSheet(content: const PriceFilterSheet());
                },
                borderRadiusGeometry: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              const SizedBox(height: 16),
              FilterItem(title: "Выберите регион", iconPath: PIcons.locationIcon, onTap: () {}),
              const SizedBox(height: 16),
              Text('Цена, сум', style: TextStyle(color: context.color.textStrong)),
              const SizedBox(height: 8),
              Row(
                children: [
                  CommonTextfield(hint: "от 5000"),
                  const SizedBox(width: 8),
                  CommonTextfield(hint: "до 15000000"),
                ],
              ),
              const SizedBox(height: 16),
              Text('Состояние', style: TextStyle(color: context.color.textStrong)),
              const SizedBox(height: 8),
              Row(
                children: [
                  CommonTextfield(hint: "Новый"),
                  const SizedBox(width: 8),
                  CommonTextfield(hint: "Б/у"),
                  const SizedBox(width: 8),
                  CommonTextfield(hint: "Как новый"),
                ],
              ),
              const SizedBox(height: 16),
              Text('Тип сделки', style: TextStyle(color: context.color.textStrong)),
              const SizedBox(height: 8),
              Row(
                children: [
                  CommonTextfield(hint: "Бесплатно"),
                  const SizedBox(width: 8),
                  CommonTextfield(hint: "Обмен"),
                ],
              ),
              const Spacer(),
              ButtonWithScale(
                onPressed: () {
                  context.pop();
                },
                text: "Показать результаты",
                textStyle: TextStyle(color: context.color.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
