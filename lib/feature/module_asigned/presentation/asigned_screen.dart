import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employee_app/core/constant/app_image_constant.dart';
import 'package:employee_app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/logger_config.dart';

enum ApprovalStatus {
  accepted('Đã phê duyệt', AppImageConstant.accepted, AppColors.success),
  rejected('Đã từ chối', AppImageConstant.rejected, AppColors.error),
  waiting('Chờ phê duyệt', AppImageConstant.waiting, AppColors.info);

  final String status;
  final String iconPath;
  final Color color;
  const ApprovalStatus(this.status, this.iconPath, this.color);
}

class AsignedScreen extends StatefulWidget {
  const AsignedScreen({super.key});

  @override
  State<AsignedScreen> createState() => _AsignedScreenState();
}

class _AsignedScreenState extends State<AsignedScreen> {
  ApprovalStatus _buildStatus(int index) {
    if (index % 2 == 0) {
      return ApprovalStatus.rejected;
    } else if (index % 3 == 0) {
      return ApprovalStatus.waiting;
    } else {
      return ApprovalStatus.accepted;
    }
  }

  final List<String> listApproval = ApprovalStatus.values.map((e) => e.status).toList();
  String? selectedValue;

  _onChangeCategory(String? category) {
    setState(() {
      selectedValue = category;
    });
  }

  _onTapAsignedCard(int? index) {
    prt0.d('tapped card $index');
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Row(
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Tất cả các đơn',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: listApproval
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: AppTextTheme.label1Bold.copyWith(color: AppColors.textPrimaryLight),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: _onChangeCategory,
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  width: 160,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: color.primaryContainer),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down_circle_rounded,
                    color: AppColors.textPrimaryLight,
                    size: 23,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.yellow,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: color.primaryContainer,
                  ),
                  offset: const Offset(0, -10),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: WidgetStateProperty.all(3),
                    thumbVisibility: WidgetStateProperty.all(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _asignedCard(
                index: index,
                onTap: () {
                  _onTapAsignedCard(index);
                },
              );
            },
            childCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _asignedCard({required int index, required GestureLongPressCallback? onTap}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onLongPress: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phê duyệt đơn nghỉ ốm của Nguyen Van Binh',
                        style: AppTextTheme.label1Bold.copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: 'Ngày tạo: ',
                          style: AppTextTheme.label2Regular.copyWith(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: '20/11/1999',
                              style: AppTextTheme.label1Bold.copyWith(color: AppColors.textPrimaryLight),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: 'Người tạo: ',
                          style: AppTextTheme.label2Regular.copyWith(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Nguyen Van Binh',
                              style: AppTextTheme.label1Bold.copyWith(color: AppColors.textPrimaryLight),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        _buildStatus(index).iconPath,
                        colorFilter: ColorFilter.mode(
                          _buildStatus(index).color,
                          BlendMode.srcIn,
                        ),
                        height: 25,
                      ),
                      SizedBox(height: 5),
                      Text(
                        _buildStatus(index).status,
                        style: AppTextTheme.caption2Bold.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  PinnedHeaderDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(PinnedHeaderDelegate oldDelegate) {
    return oldDelegate.maxHeight != maxHeight || oldDelegate.minHeight != minHeight || oldDelegate.child != child;
  }
}
