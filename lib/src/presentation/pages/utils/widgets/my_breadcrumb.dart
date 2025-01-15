import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:timbox/src/presentation/pages/utils/widgets/my_responsiv.dart';

import '../theme/app_style.dart';
import 'my_breadcrumb_item.dart';
import 'my_constant.dart';
import 'my_router.dart';
import 'my_spacing.dart';
import 'my_text.dart';

class MyBreadcrumb extends StatelessWidget {
  final List<MyBreadcrumbItem> children;
  final bool hideOnMobile;

  MyBreadcrumb({super.key, required this.children, this.hideOnMobile = true}) {
    if (MyConstant.constant.defaultBreadCrumbItem != null) {
      children.insert(0, MyConstant.constant.defaultBreadCrumbItem!);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < children.length; i++) {
      var item = children[i];
      if (item.active || item.route == null) {
        list.add(MyText.labelMedium(
          children[i].name,
          fontWeight: 500,
          fontSize: 13,
          letterSpacing: 0,
        ));
      } else {
        list.add(InkWell(
            onTap: () => {
                  if (item.route != null)
                    MyRouter.pushReplacementNamed(context, item.route!)
                },
            child: MyText.labelMedium(
              children[i].name,
              fontWeight: 500,
              fontSize: 13,
              letterSpacing: 0,
              color: theme.colorScheme.primary,
            )));
      }
      if (i < children.length - 1) {
        list.add(MySpacing.width(12));
        list.add(Icon(LucideIcons.chevronRight, size: 16));
        list.add(MySpacing.width(12));
      }
    }
    return MyResponsive(builder: (_, __, type) {
      if (type.isMobile && hideOnMobile) {
        return SizedBox();
      } else {
        return Row(mainAxisSize: MainAxisSize.min, children: list);
      }
    });
  }
}
