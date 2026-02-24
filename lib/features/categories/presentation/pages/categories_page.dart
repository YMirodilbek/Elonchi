import 'package:elonchi/constants/constants.dart';
import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/scale_animation.dart';
import 'package:elonchi/features/categories/data/category_response.dart';
import 'package:elonchi/features/categories/presentation/blocs/bloc/category_bloc.dart';
import 'package:elonchi/features/categories/presentation/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late final CategoryBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<CategoryBloc>();
    bloc.add(const GetCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return SizedBox(
          height: context.height * 0.8,
          child: Column(
            children: [
              Row(
                children: [
                  WScaleAnimation(
                    onTap: () {
                      if (state.canGoBack) {
                        bloc.add(const NavigateBackEvent());
                      } else {
                        context.pop();
                      }
                    },
                    child: SvgPicture.asset(PIcons.arrowLeftIcon, color: context.color.iconStrong),
                  ),
                  const Spacer(),
                  Text(
                    state.isShowingModels
                        ? 'categories.models'.tr()
                        : (state.navigationStack.isNotEmpty
                              ? state.navigationStack.last.title
                              : 'categories.title'.tr()),
                    style: TextStyle(color: context.color.textStrong, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 20),
                  const Spacer(),
                ],
              ),

              const SizedBox(height: 16),

              if (state.isLoading)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else if (state.error != null)
                Expanded(child: Center(child: Text("${'categories.error'.tr()}${state.error}")))
              else
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final category = state.currentCategories[index];
                      return CategorySelectItem(
                        categoryResponse: category,
                        onCategoryTap: () {
                          // Has models? Pop immediately with data
                          if (category.models != null && category.models!.isNotEmpty) {
                            final Map<String, List<ModelItem?>?> data = {category.name ?? '': category.models};
                            context.pop(data);
                            return;
                          }

                          // No models? Navigate deeper
                          bloc.add(NavigateToSubCategoryEvent(category));
                        },
                      );
                    },
                    itemCount: state.currentCategories.length,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
