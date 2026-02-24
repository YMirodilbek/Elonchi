import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/bottom_sheet.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/core/widgets/cummon_textfield.dart';
import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/categories/presentation/blocs/bloc/category_bloc.dart';
import 'package:elonchi/features/categories/presentation/pages/categories_page.dart';
import 'package:elonchi/features/home/domain/entities/get_product_request.dart';
import 'package:elonchi/features/home/presentation/blocs/filters_bloc/filters_bloc.dart';
import 'package:elonchi/features/home/presentation/widgets/filter_item.dart';
import 'package:elonchi/features/home/presentation/widgets/filter_top_part.dart';
import 'package:elonchi/features/home/presentation/widgets/price_filter_sheet.dart';
import 'package:elonchi/features/regions/data/regions_response.dart';
import 'package:elonchi/features/regions/presentation/bloc/regions_bloc.dart';
import 'package:elonchi/features/regions/presentation/pages/regions.dart';
import 'package:elonchi/injector_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FiltersPage extends StatefulWidget {
  final GetProductRequest request;
  const FiltersPage({super.key, required this.request});

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  late final FiltersBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<FiltersBloc>();
    bloc.add(InitFiltersEvent(widget.request));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FiltersBloc, FiltersState>(
        builder: (context, state) {
          return SafeArea(
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
                    title: state.request.categoryName ?? "Категория",
                    iconPath: PIcons.menu2Icon,
                    onTap: () async {
                      final Map<String, List<ModelItem?>?>? data = await triggerBottomSheet(
                        content: BlocProvider(create: (context) => sl<CategoryBloc>(), child: const CategoriesPage()),
                      );
                      if (data != null && data.isNotEmpty) {
                        final categoryName = data.keys.first;
                        final models = data.values.first;
                        final categoryId = (models?.isNotEmpty ?? false) ? models!.first?.id ?? 0 : 0;
                        bloc.add(ChangeCategoryEvent(category: categoryName, categoryId: categoryId));
                      }
                    },
                    borderRadiusGeometry: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
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
                  FilterItem(
                    title: state.region.isEmpty ? "Выберите регион" : state.region,
                    iconPath: PIcons.locationIcon,
                    onTap: () async {
                      final data = await triggerBottomSheet<RegionResponse>(
                        content: BlocProvider(create: (context) => sl<RegionsBloc>(), child: const RegionsSheet()),
                      );
                      if (data != null) {
                        bloc.add(ChangeRegionEvent(region: data.name ?? '', regionId: data.id ?? 0));
                      }
                    },
                  ),
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
          );
        },
      ),
    );
  }
}
