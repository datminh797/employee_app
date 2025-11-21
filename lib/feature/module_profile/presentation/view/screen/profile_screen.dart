import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/core/constant/app_image_constant.dart';
import 'package:employee_app/core/extension/size_extension.dart';
import 'package:employee_app/core/theme/app_theme.dart';
import 'package:employee_app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/logger_config.dart';
import '../../../../../generated/l10n.dart';
import '../../../../module_global/presentation/bloc/language/language_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _currentLanguageCode = 'vi';
  bool _isProfileExpanded = false;

  final List<Map<String, String>> _supportedLanguages = [
    {'code': 'vi', 'name': 'Việt Nam'},
    {'code': 'en', 'name': 'English'},
  ];

  _onChangeLanguage() async {
    final locale = S.of(context);

    final selectedCode = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                locale.selectLanguage,
                style: AppTextTheme.body1Bold.copyWith(fontSize: 18),
              ),
            ),
            ..._supportedLanguages.map((lang) {
              final isSelected = lang['code'] == _currentLanguageCode;
              return ListTile(
                title: Text(
                  lang['name']!,
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
                onTap: () {
                  Navigator.pop(context, lang['code']);
                },
              );
            }),
            const SizedBox(height: 10),
          ],
        );
      },
    );

    if (selectedCode != null && selectedCode != _currentLanguageCode) {
      setState(() {
        _currentLanguageCode = selectedCode;
        context.read<LanguageBloc>().add(
              LanguageChangeRequest(Locale(selectedCode)),
            );
      });
    }
  }

  _onLogout() {
    prt0.d('logout');
  }

  _onViewPayslip() {
    prt0.d('view payslip');
  }

  _onEditProfile() {
    prt0.d('edit profile');
  }

  @override
  void initState() {
    _currentLanguageCode = context.read<LanguageBloc>().state.locale.languageCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _profileView(),
          _incomeButton(),
          _contractViewButton(),
          _languageButton(),
          _logoutButton(),
        ],
      ),
    );
  }

  Widget _contractViewButton() {
    final localization = S.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 65.0.h(),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImageConstant.contract,
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    AppColors.textPrimaryLight,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  localization.contractInfo,
                  style: AppTextTheme.body1Bold.copyWith(color: AppColors.textPrimaryLight),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileView() {
    final color = Theme.of(context).colorScheme;
    final localization = S.of(context);

    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      curve: Curves.linear,
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(22)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              setState(() {
                _isProfileExpanded = !_isProfileExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w(), vertical: 5.0.h()),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: CachedNetworkImageProvider(
                                'https://as2.ftcdn.net/v2/jpg/03/31/69/91/1000_F_331699188_lRpvqxO5QRtwOM05gR50ImaaJgBx68vi.jpg',
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0.w()),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Nguyen van anh',
                                  style: AppTextTheme.body1Bold,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Nguyenvananh@gmail.com',
                                  style: AppTextTheme.label2Regular,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (_isProfileExpanded) ...[
                        SizedBox(height: 5.0.h()),
                        _basicInfoItem(
                          localization.phoneNumber,
                          '097229107',
                        ),
                        _basicInfoItem(
                          localization.bankInfo,
                          'MB Bank \n012345678998',
                        ),
                        _basicInfoItem(
                          localization.emrgencyName,
                          'Nguyen Van Nam',
                        ),
                        _basicInfoItem(
                          localization.emrgencyNumber,
                          '0912156454',
                        ),
                        SizedBox(height: 10.0.h()),
                      ]
                    ],
                  ),
                  _isProfileExpanded
                      ? Positioned(
                          top: 15.0.h(),
                          right: 0,
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: _onEditProfile,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: color.primary,
                                    size: 20.0.h(),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    localization.edit,
                                    style: AppTextTheme.caption1Bold.copyWith(color: AppColors.absenceDayMarker),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _basicInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: AppTextTheme.label2Regular,
            ),
          ),
          SizedBox(width: 10.0.w()),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextTheme.body2Bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _incomeButton() {
    final localization = S.of(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 65.0.h(),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: _onViewPayslip,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImageConstant.paySlip,
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    AppColors.textPrimaryLight,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  localization.payslip,
                  style: AppTextTheme.body1Bold.copyWith(color: AppColors.textPrimaryLight),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _languageButton() {
    final locale = S.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 65.0.h(),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: _onChangeLanguage,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppImageConstant.language,
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    AppColors.textPrimaryLight,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  locale.language,
                  style: AppTextTheme.body1Bold.copyWith(color: AppColors.textPrimaryLight),
                ),
                Spacer(),
                IconButton(
                  onPressed: _onChangeLanguage,
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoutButton() {
    final localization = S.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 65.0.h(),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: _onLogout,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(AppImageConstant.logout,
                    width: 25,
                    height: 25,
                    colorFilter: ColorFilter.mode(
                      AppColors.textPrimaryLight,
                      BlendMode.srcIn,
                    )),
                SizedBox(width: 10),
                Text(
                  localization.logout,
                  style: AppTextTheme.body1Bold.copyWith(color: AppColors.textPrimaryLight),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
