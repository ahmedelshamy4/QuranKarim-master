import 'package:flutter/material.dart';
import 'package:quran_karim/app_components.dart';
import 'package:quran_karim/utils/helper/size_configration_helper.dart';

import '../drawer_view/drawer_view.dart';
import 'components.dart';

class HomeView extends StatefulWidget {
  static const id = 'HomeView';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    SizeConfigurationHelper.initSizeConfiguration(context);
    return Scaffold(
      drawer: const DrawerView(),
      appBar: buildAppBar(context),
      body: LayoutBuilder(
        builder: (_, constraints) {
          if (SizeConfigurationHelper.screenOrientation ==
              Orientation.portrait) {
            return const BuildHomePortraitLayout();
          } else {
            return const BuildHomeLandScapeLayout();
          }
        },
      ),
    );
  }
}
