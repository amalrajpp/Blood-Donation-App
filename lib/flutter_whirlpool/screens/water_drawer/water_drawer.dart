import 'package:flutter/material.dart';
import 'package:blood/flutter_whirlpool/screens/water_drawer/water_slider.dart';
import 'package:blood/flutter_whirlpool/shared/colors.dart';
import 'package:blood/flutter_whirlpool/shared/consts.dart';

import '../../../fitness_app_theme.dart';
import '../../../mobile/theme/colors.dart';
import '../../shared/widgets/neumorphic_icon_button.dart';

class WaterDrawer extends StatefulWidget {
  const WaterDrawer({Key? key}) : super(key: key);

  @override
  State<WaterDrawer> createState() => _WaterDrawerState();
}

class _WaterDrawerState extends State<WaterDrawer> {
  double waterValue = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: globalEdgeMarginValue,
          top: drawerButtonMarginTop,
        ),
        child: WaterSlider(
          minValue: 0,
          maxValue: 90,
          initValue: waterValue,
          onValueChanged: (newValue) => waterValue = newValue,
        ),
      ),
    );
  }
}
