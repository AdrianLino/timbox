import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:timbox/src/presentation/pages/home/layouts/right_bar.dart';
import 'package:timbox/src/presentation/pages/home/layouts/top_bar.dart';
import 'package:timbox/src/presentation/pages/utils/widgets/my_responsiv.dart';

import '../../utils/controller/layout_controller.dart';
import '../../utils/theme/admin_theme.dart';
import '../../utils/theme/app_style.dart';
import '../../utils/theme/theme_customizer.dart';
import '../../utils/widgets/my_spacing.dart';
import 'left_bar.dart';


class Layout extends StatelessWidget {
  final Widget? child;

  final LayoutController controller = LayoutController();
  final topBarTheme = AdminTheme.theme.topBarTheme;
  final contentTheme = AdminTheme.theme.contentTheme;

  Layout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MyResponsive(builder: (BuildContext context, _, screenMT) {
      return GetBuilder(
          init: controller,
          builder: (controller) {
            return screenMT.isMobile ? mobileScreen() : largeScreen();
          });
    });
  }

  Widget mobileScreen() {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              ThemeCustomizer.setTheme(
                  ThemeCustomizer.instance.theme == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark);
            },
            child: Icon(
              ThemeCustomizer.instance.theme == ThemeMode.dark
                  ? LucideIcons.sun
                  : LucideIcons.moon,
              size: 18,
              color: topBarTheme.onBackground,
            ),
          ),
          MySpacing.width(20)
        ],
      ),
      drawer: LeftBar(),
      body: SingleChildScrollView(
        key: controller.scrollKey,
        child: child,
      ),
    );
  }

  Widget largeScreen() {
    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: RightBar(),
      body: Row(
        children: [
          LeftBar(isCondensed: ThemeCustomizer.instance.leftBarCondensed),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  padding:
                      MySpacing.fromLTRB(0, 58 + flexSpacing, 0, flexSpacing),
                  key: controller.scrollKey,
                  child: child,
                ),
              ),
              Positioned(top: 0, left: 0, right: 0, child: TopBar()),
            ],
          )),
        ],
      ),
    );
  }


}
