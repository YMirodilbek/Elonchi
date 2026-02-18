import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/my_products/presentation/widgets/brand_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BrandsSheet extends StatefulWidget {
  final List<ModelItem> brands;
  const BrandsSheet({super.key, required this.brands});

  @override
  State<BrandsSheet> createState() => _BrandsSheetState();
}

class _BrandsSheetState extends State<BrandsSheet> {
  ModelItem? selectedBrand;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          Text(
            'Выберите бренд',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.color.textStrong),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => WScaleAnimation(
                onTap: () {
                  setState(() {
                    selectedBrand = widget.brands[index];
                  });
                  context.pop(widget.brands[index]);
                },
                child: BrandItem(
                  brand: widget.brands[index].name ?? "",
                  selected: selectedBrand?.id == widget.brands[index].id,
                ),
              ),
              itemCount: widget.brands.length,
            ),
          ),
        ],
      ),
    );
  }
}
