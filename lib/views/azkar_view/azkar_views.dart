import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:quran_karim/app_components.dart';
import 'package:quran_karim/viewModel/azkar/azkar_view_model.dart';
import 'package:quran_karim/views/azkar_view/azkar_details_view.dart';
import 'package:quran_karim/views/azkar_view/components.dart';

import '../../viewModel/azkar/states.dart';

class AzkarView extends StatefulWidget {
  static const String id = 'AzkarView';

  const AzkarView({Key? key}) : super(key: key);

  @override
  State<AzkarView> createState() => _AzkarViewState();
}

class _AzkarViewState extends State<AzkarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDefaultAppBar(title: 'azkar'.tr()),
      body: Consumer<AzkarViewModel>(
        builder: (context, provider, child) {
          if (provider.categoriesStates == AzkarCategoriesStates.Initial) {
            provider.getCategories(context);
            return const BuildLoadingWidget();
          } else if (provider.categoriesStates ==
              AzkarCategoriesStates.Loading) {
            return const BuildLoadingWidget();
          } else if (provider.categoriesStates ==
              AzkarCategoriesStates.Loaded) {
            return FadeInRight(
              child: ListView.separated(
                padding: symmetricVerticalPadding1(),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return BuildAzkarCategoryWidgetItem(
                    name: provider.categories[index].name,
                    onClick: () async {
                      await provider.getAzkarDetails(context,
                          categoryId: provider.categories[index].id);
                      materialNavigator(
                        context,
                        AzkarDetailsView(
                            title: provider.categories[index].name),
                      );
                    },
                  );
                },
                separatorBuilder: (_, index) => verticalSpace2(),
                itemCount: provider.categories.length,
              ),
            );
          } else {
            return BuildErrorWidget(
              errorResult: provider.error,
            );
          }
        },
      ),
    );
  }
}
