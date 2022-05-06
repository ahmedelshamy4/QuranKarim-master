import 'package:after_layout/after_layout.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quran_karim/viewModel/ahadith/ahadith_view_model.dart';
import 'package:quran_karim/views/ahadith_view/components.dart';

import '../../app_components.dart';
import '../../viewModel/ahadith/states.dart';

class AhadithView extends StatefulWidget {
  static const id = 'AhadithView';

  const AhadithView({Key? key}) : super(key: key);

  @override
  State<AhadithView> createState() => _AhadithViewState();
}

class _AhadithViewState extends State<AhadithView> with AfterLayoutMixin {
  late AhadithViewModel _ahadithViewModel;
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _refreshKey = GlobalKey();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void afterFirstLayout(BuildContext context) {
    _ahadithViewModel = Provider.of<AhadithViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    _refreshController.dispose();
    _ahadithViewModel.disposeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildDefaultAppBar(title: 'hades'.tr()),
      body: Consumer<AhadithViewModel>(
        builder: (context, provider, child) {
          if (provider.states == AhadithStates.Loading) {
            return const BuildLoadingWidget();
          } else if (provider.states == AhadithStates.Loaded) {
            return FadeInRight(
              child: SmartRefresher(
                key: _refreshKey,
                controller: _refreshController,
                enablePullUp: true,
                physics: const BouncingScrollPhysics(),
                footer: const ClassicFooter(
                  loadStyle: LoadStyle.ShowWhenLoading,
                ),
                onRefresh: () {
                  provider.onRefresh(context,
                      refreshController: _refreshController);
                  if (provider.refreshState ==
                      AhadithOnRefreshState.OnRefreshErrorState) {
                    showToast(toastValue: provider.refreshError);
                  }
                },
                onLoading: () {
                  provider.onLoad(context, controller: _refreshController);
                  if (provider.loadState ==
                      AhadithOnLoadState.OnLoadErrorState) {
                    showToast(toastValue: provider.refreshError);
                  }
                },
                child: ListView.separated(
                  padding: padding2(),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return index == 0
                        ? BuildSearchWidget(
                            controller: _controller,
                            suffixIcon: BuildDefaultIconButton(
                              icon: _controller.text == ''
                                  ? Icons.search
                                  : Icons.close,
                              onClick: () {
                                _controller.clear();
                                provider.clearSearchTerms();
                              },
                            ),
                            onChanged: (String? value) {
                              provider.searchQuery(value!);
                            })
                        : BuildHadithItemWidget(
                            hadith: provider.ahadithDisplayed[index - 1]);
                  },
                  separatorBuilder: (_, index) => verticalSpace2(),
                  itemCount: provider.ahadithDisplayed.length + 1,
                ),
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
