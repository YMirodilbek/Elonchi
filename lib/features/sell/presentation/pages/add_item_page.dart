import 'package:elonchi/core/extension/extension.dart';
import 'package:elonchi/core/widgets/button_with_scale.dart';
import 'package:elonchi/features/sell/presentation/page_view/add_characteristics.dart';
import 'package:elonchi/features/sell/presentation/page_view/add_decription.dart';
import 'package:elonchi/features/sell/presentation/page_view/add_name.dart';
import 'package:elonchi/features/sell/presentation/page_view/contacts.dart';
import 'package:elonchi/features/sell/presentation/page_view/image_add.dart';
import 'package:elonchi/features/sell/presentation/page_view/meet_place.dart';
import 'package:elonchi/features/sell/presentation/page_view/requirements.dart';
import 'package:elonchi/features/sell/presentation/page_view/selecte_category.dart';
import 'package:elonchi/features/sell/presentation/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> forms = [
    const ImageAddForm(),
    const AddNameForm(),
    const SelectCategoryForm(),
    const RequirementsForm(),
    const ParametsForm(),
    const DecriptionsForm(),
    const MeetPlaceForm(),
    const ContancsForm(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            children: [
              ProgressBar(value: 0.2, onBackTap: () {}),
              const SizedBox(height: 8),
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemBuilder: (context, index) => forms[index],
                  itemCount: forms.length,
                ),
              ),
              const SizedBox(height: 16),
              ButtonWithScale(
                text: 'auth.login.continue'.tr(),
                onPressed: () {
                  _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.linear);
                },
                textStyle: TextStyle(color: context.color.white, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
