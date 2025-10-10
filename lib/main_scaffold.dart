import 'package:employee_app/core/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'core/constant/app_image_constant.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int currentPageIndex = 0;

  final List<Widget> listTab = [
    NavigationDestination(
      selectedIcon: SvgPicture.asset(
        AppImageConstant.navHome,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 20,
        height: 20,
      ),
      icon: SvgPicture.asset(
        AppImageConstant.navHome,
        width: 20,
        height: 20,
      ),
      label: 'Trang chủ',
    ),
    NavigationDestination(
      selectedIcon: SvgPicture.asset(
        AppImageConstant.navFeed,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 20,
        height: 20,
      ),
      icon: SvgPicture.asset(
        AppImageConstant.navFeed,
        width: 20,
        height: 20,
      ),
      label: 'Bảng tin',
    ),
    NavigationDestination(
      selectedIcon: SvgPicture.asset(
        AppImageConstant.navTask,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 20,
        height: 20,
      ),
      icon: SvgPicture.asset(
        AppImageConstant.navTask,
        width: 20,
        height: 20,
      ),
      label: 'Phân quyền',
    ),
    NavigationDestination(
      selectedIcon: SvgPicture.asset(
        AppImageConstant.navUser,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 20,
        height: 20,
      ),
      icon: SvgPicture.asset(
        AppImageConstant.navUser,
        width: 20,
        height: 20,
      ),
      label: 'Cá nhân',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: AppTextTheme.label2Bold.copyWith(color: color.primary),
              ),
              Text(
                'Nguyen Van A',
                style: AppTextTheme.body2Bold.copyWith(color: color.primary),
              ),
            ],
          ),
          centerTitle: false,
        ),
        body: widget.child,
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: Colors.white,
          height: 70,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: color.primary,
          selectedIndex: currentPageIndex,
          destinations: listTab,
        ),
      ),
    );
  }
}
