import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/widgets/loading/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constant/app_image_constant.dart';
import '../../../../../core/constant/app_text_constant.dart';
import '../../../../../core/theme/text_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolled = false;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final newHasScrolled = _scrollController.offset > 5.0;

    if (_hasScrolled != newHasScrolled) {
      setState(() {
        _hasScrolled = newHasScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          _topBar(),
          SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 25),
              controller: _scrollController,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text('Home content 1'),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 300,
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text('Home content 2'),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 300,
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text('Home content 3'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
        },
        child: Icon(
          Icons.add,
          color: theme.primary,
          size: 25,
        ),
      ),
    );
  }

  Material _topBar() {
    final color = Theme.of(context).colorScheme;
    final topPadding = MediaQuery.of(context).padding.top + 85;

    return Material(
      elevation: _hasScrolled ? 8.0 : 0.0,
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(38),
        right: Radius.circular(38),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: topPadding,
        decoration: BoxDecoration(color: color.primaryContainer),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        // margin: EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppTextConstant.welcome,
                  style: AppTextTheme.body2Regular.copyWith(color: color.primary),
                ),
                Text(
                  '\t Nguyen Van Anh',
                  style: AppTextTheme.body2Bold.copyWith(color: color.primary),
                ),
              ],
            ),
            Spacer(),
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
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                'https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
