import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/core/route/route_name.dart';
import 'package:employee_app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'core/constant/app_image_constant.dart';
import 'core/constant/app_text_constant.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentPageIndex = 0;

  final List<String> _tabPath = [
    RouteName.home.path,
    RouteName.feed.path,
    RouteName.asigned.path,
    RouteName.profile.path,
  ];

  final List<Widget> _tabButton = [
    navButton(icon: AppImageConstant.navHome, label: AppTextConstant.navHome),
    navButton(icon: AppImageConstant.navNewsFeed, label: AppTextConstant.navNewsFeed),
    navButton(icon: AppImageConstant.navAsigned, label: AppTextConstant.navAsigned),
    navButton(icon: AppImageConstant.navProfile, label: AppTextConstant.navProfile),
  ];

  _onTabChange(int index) {
    if (_currentPageIndex == index) {
      return;
    }
    final targetPath = _tabPath[index];
    context.go(targetPath);
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final currentLocation = GoRouterState.of(context).matchedLocation;
    final index = _tabPath.indexOf(currentLocation);
    if (index != -1 && index != _currentPageIndex) {
      setState(() {
        _currentPageIndex = index;
      });
    }
    super.didChangeDependencies();
  }

  String getTitleTab(String currentLocation) {
    switch (_currentPageIndex) {
      case 1:
        return AppTextConstant.appBarNewsFeed;
      case 2:
        return AppTextConstant.appBarAsigned;
      case 3:
        return AppTextConstant.appBarProfile;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isHomeTab = _currentPageIndex == 0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        appBar: isHomeTab ? null : appBar(),
        body: widget.child,
        bottomNavigationBar: navigationBar(),
      ),
    );
  }

  Widget navigationBar() {
    final color = Theme.of(context).colorScheme;
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      backgroundColor: Colors.white,
      height: 70,
      onDestinationSelected: _onTabChange,
      indicatorColor: color.primary,
      selectedIndex: _currentPageIndex,
      destinations: _tabButton,
    );
  }

  PreferredSizeWidget homeAppBar() {
    final color = Theme.of(context).colorScheme;
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppTextConstant.welcome,
            style: AppTextTheme.body2Regular.copyWith(color: color.primary),
          ),
          Text(
            'Nguyen Van Anh',
            style: AppTextTheme.body2Bold.copyWith(color: color.primary),
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppImageConstant.notification,
              width: 30,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(color.primary, BlendMode.srcIn),
            )),
        SizedBox(width: 5),
        CircleAvatar(
          radius: 25,
          backgroundImage: CachedNetworkImageProvider(
            'https://img.tripi.vn/cdn-cgi/image/width=700,height=700/https://gcs.tripi.vn/public-tripi/tripi-feed/img/482621AUw/anh-mo-ta.png',
          ),
        ),
        SizedBox(width: 15),
      ],
    );
  }

  PreferredSizeWidget appBar() {
    final currentLocation = GoRouterState.of(context).fullPath ?? '';

    final color = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTitleTab(currentLocation),
            style: AppTextTheme.headline1Bold.copyWith(color: color.primary),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  static Widget navButton({
    required String icon,
    required String label,
  }) {
    return NavigationDestination(
      selectedIcon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 20,
        height: 20,
      ),
      icon: SvgPicture.asset(
        icon,
        width: 20,
        height: 20,
      ),
      label: label,
    );
  }
}
