import 'package:employee_app/core/constant/app_image_constant.dart';
import 'package:employee_app/core/theme/app_theme.dart';
import 'package:employee_app/core/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constant/app_text_constant.dart';
import '../../../../../core/utils/logger_config.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _onLogout() {
    prt0.d('logout');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
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
                        AppTextConstant.logout,
                        style: AppTextTheme.body1Bold.copyWith(color: AppColors.textPrimaryLight),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
