import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/core/extension/size_extension.dart';
import 'package:employee_app/core/theme/app_theme.dart';
import 'package:employee_app/widgets/box_shadow/common_box_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/constant/app_image_constant.dart';
import '../../../../../core/theme/text_theme.dart';
import '../../../../../generated/l10n.dart';
import '../../../../module_asigned/presentation/asigned_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<String>> _absences = {
    DateTime(2025, 10, 15): ['John Doe', 'Jane Smith'],
    DateTime(2025, 10, 1): ['Alice Johnson'],
    DateTime(2025, 10, 20): ['Bob Williams', 'Carol Martinez'],
  };

  final List<DateTime> _absenceDay = [
    DateTime(2025, 10, 10),
    DateTime(2025, 10, 15),
    DateTime(2025, 10, 17),
  ];

  final List<Color> _absenceProgressBarColors = [
    AppColors.blue100,
    AppColors.blue200,
    AppColors.blue300,
    AppColors.blue400,
    AppColors.blue500,
    AppColors.blue600,
    AppColors.blue700,
    AppColors.blue800,
  ];
  List<String> _getAbsencesForDay(DateTime day) {
    return _absences[DateTime(day.year, day.month, day.day)] ?? [];
  }

  // final List<Map<String, dynamic>> companyItems = [
  //   {
  //     'icon': Icons.home,
  //     'label': 'Bảng tin công ty',
  //     'path': '/news',
  //   },
  //   {
  //     'icon': Icons.search,
  //     'label': 'Sơ đồ tổ chức',
  //     'path': '/organize',
  //   },
  //   {
  //     'icon': Icons.settings,
  //     'label': 'Khảo sát',
  //     'path': '/survey',
  //   },
  //   {
  //     'icon': Icons.person,
  //     'label': 'Khen thưởng',
  //     'path': '/award',
  //   },
  //   {
  //     'icon': Icons.notifications,
  //     'label': 'Sự kiện nội bộ',
  //     'path': '/events',
  //   },
  // ];

  List<Map<String, dynamic>> _getCompanyItems() {
    final localization = S.of(context);

    return [
      {
        'icon': AppImageConstant.homeCompanyNews,
        'label': localization.companyNews,
        'path': '/news',
      },
      {
        'icon': AppImageConstant.homeCompanyOrganize,
        'label': localization.organization,
        'path': '/organize',
      },
      {
        'icon': AppImageConstant.homeCompanySurvey,
        'label': localization.survey,
        'path': '/survey',
      },
      {
        'icon': AppImageConstant.homeCompanyAward,
        'label': localization.award,
        'path': '/award',
      },
      {
        'icon': AppImageConstant.homeCompanySurvey,
        'label': localization.survey,
        'path': '/survey',
      },
    ];
  }

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

  _onChangeCalendarFormat() {
    setState(() {
      if (_calendarFormat == CalendarFormat.week) {
        _calendarFormat = CalendarFormat.month;
      } else {
        _calendarFormat = CalendarFormat.week;
      }
    });
  }

  _addingActionList() {
    final localization = S.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                localization.listRequest,
                style: AppTextTheme.title1Bold,
              ),
            ),
            ListTile(
              title: Text(
                localization.scanQR,
                style: AppTextTheme.body1Regular,
              ),
              trailing: Icon(
                Icons.qr_code,
                color: AppColors.textPrimaryLight,
              ),
              onTap: () {
                //
              },
            ),
            ListTile(
              title: Text(
                localization.checkin,
                style: AppTextTheme.body1Regular,
              ),
              trailing: SvgPicture.asset(
                AppImageConstant.checkin,
                width: 25,
                colorFilter: ColorFilter.mode(AppColors.textPrimaryLight, BlendMode.srcIn),
              ),
              onTap: () {
                //
              },
            ),
            ListTile(
              title: Text(
                localization.leaveRequest,
                style: AppTextTheme.body1Regular,
              ),
              trailing: SvgPicture.asset(
                AppImageConstant.calendar,
                width: 25,
                colorFilter: ColorFilter.mode(AppColors.textPrimaryLight, BlendMode.srcIn),
              ),
              onTap: () {
                //
              },
            ),
            ListTile(
              title: Text(
                localization.createTicket,
                style: AppTextTheme.body1Regular,
              ),
              trailing: SvgPicture.asset(
                AppImageConstant.request,
                width: 25,
                colorFilter: ColorFilter.mode(AppColors.textPrimaryLight, BlendMode.srcIn),
              ),
              onTap: () {
                //
              },
            ),
            SizedBox(height: 15.0.h()),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final localization = S.of(context);

    return Stack(
      children: [
        CustomScrollView(
          shrinkWrap: true,
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: PinnedHeaderDelegate(
                maxHeight: 150,
                minHeight: 150,
                child: _topBar(),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20.0)),
            SliverToBoxAdapter(child: _calendarView()),
            SliverToBoxAdapter(child: SizedBox(height: 15.0)),
            SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _absenceView(),
                  _attendanceView(),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15.0)),
            SliverToBoxAdapter(child: _incompleteTaskView()),
            SliverToBoxAdapter(child: SizedBox(height: 15.0)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 3.0, top: 10),
                child: Text(
                  localization.aboutCompany,
                  style: AppTextTheme.body2Bold.copyWith(color: AppColors.textPrimaryLight),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              sliver: DecoratedSliver(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: commonBoxShadow,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    childAspectRatio: 1.2,
                    // crossAxisSpacing: 5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _companyCard(
                        icon: _getCompanyItems()[index]['icon'],
                        label: _getCompanyItems()[index]['label'],
                        path: _getCompanyItems()[index]['path'],
                      );
                    },
                    childCount: _getCompanyItems().length,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 25.0)),
          ],
        ),
        _quickActionButton(),
      ],
    );
  }

  Widget _companyCard({required String icon, required String label, required String path}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            // context.goNamed();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: 30.0.w(),
              ),
              SizedBox(height: 7.0.h()),
              Text(
                label,
                style: AppTextTheme.caption1Bold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickActionButton() {
    final color = Theme.of(context).colorScheme;

    return Positioned(
      bottom: 10,
      right: 15,
      child: IconButton(
        splashRadius: 30,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color.primaryContainer),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0.r()),
          )),
          elevation: WidgetStatePropertyAll<double>(3),
          shadowColor: WidgetStatePropertyAll<Color>(Colors.grey),
        ),
        onPressed: _addingActionList,
        icon: Icon(
          Icons.add,
          color: color.primary,
          size: 28.0.h(),
        ),
      ),
    );
  }

  Widget _incompleteTaskView() {
    final localization = S.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: commonBoxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.incompleteTask,
                  style: AppTextTheme.body2Bold.copyWith(color: AppColors.textPrimaryLight),
                ),
                SvgPicture.asset(
                  AppImageConstant.pin,
                  width: 25,
                ),
              ],
            ),
          ),
          ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('Task $index', style: AppTextTheme.label2Regular),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: 3,
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _attendanceView() {
    final localization = S.of(context);

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(right: 12, left: 6),
        height: 230.0.h(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: commonBoxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localization.attendanceData,
              style: AppTextTheme.body2Bold.copyWith(color: AppColors.textPrimaryLight),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: localization.attendanceDate,
                style: AppTextTheme.caption2Regular,
                children: [
                  TextSpan(
                    text: '\n 15/10/2025',
                    style: AppTextTheme.body2Bold,
                  ),
                ],
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                text: localization.checkInTime,
                style: AppTextTheme.caption2Regular,
                children: [
                  TextSpan(
                    text: '\n 08:59:05',
                    style: AppTextTheme.body2Bold,
                  ),
                ],
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                text: localization.checkOutTime,
                style: AppTextTheme.caption2Regular,
                children: [
                  TextSpan(
                    text: '\n 18:00:01',
                    style: AppTextTheme.body2Bold,
                  ),
                ],
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                text: localization.checkInLocation,
                style: AppTextTheme.caption2Regular,
                children: [
                  TextSpan(
                    text: '\n PK. Lê Thanh Nghị - 266 Lê Thanh Nghị',
                    style: AppTextTheme.label1Bold,
                  ),
                ],
              ),
              textAlign: TextAlign.start,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _absenceView() {
    final localization = S.of(context);

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(left: 12, right: 6),
        height: 230.0.h(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: commonBoxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                localization.leaveDay,
                style: AppTextTheme.body2Bold.copyWith(color: AppColors.textPrimaryLight),
              ),
            ),
            SizedBox(height: 20.0.h()),
            SleekCircularSlider(
              appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(progressBarWidth: 10),
                customColors: CustomSliderColors(
                  progressBarColors: _absenceProgressBarColors,
                  trackColor: Colors.grey.shade400,
                ),
              ),
              onChange: null,
              innerWidget: (double dayoff) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '1.0',
                          style: AppTextTheme.display1Bold.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.1,
                          ),
                          children: [
                            TextSpan(
                              text: '/ \n12 ${localization.day}',
                              style: AppTextTheme.caption1Bold.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 35.0.h()),
                      RichText(
                        text: TextSpan(
                          text: localization.remain,
                          style: AppTextTheme.label2Regular.copyWith(color: AppColors.textSecondary),
                          children: [
                            TextSpan(
                              text: '11.0',
                              style: AppTextTheme.body2Bold.copyWith(color: AppColors.absenceDayMarker),
                            ),
                            TextSpan(
                              text: ' ${localization.day}',
                              style: AppTextTheme.label2Regular.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              min: 1,
              max: 12,
              initialValue: 11,
            ),
          ],
        ),
      ),
    );
  }

  Widget _calendarView() {
    final color = Theme.of(context).colorScheme;
    final localization = S.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 10),
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: commonBoxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localization.workDay,
                style: AppTextTheme.body2Bold.copyWith(color: AppColors.textPrimaryLight),
              ),
              IconButton(
                onPressed: _onChangeCalendarFormat,
                icon: Icon(
                  _calendarFormat == CalendarFormat.week
                      ? Icons.arrow_drop_down_circle_rounded
                      : Icons.arrow_drop_up_rounded,
                  color: color.primary,
                  size: 30,
                ),
              )
            ],
          ),
          TableCalendar(
            startingDayOfWeek: StartingDayOfWeek.monday,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            headerVisible: true,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              formatButtonShowsNext: false,
              titleCentered: true,
              titleTextFormatter: (date, locale) {
                return DateFormat('MM/yyyy').format(date);
              },
              titleTextStyle: AppTextTheme.body1Bold.copyWith(color: AppColors.textPrimaryLight),
              headerPadding: EdgeInsets.only(top: 5),
              leftChevronMargin: EdgeInsets.zero,
              rightChevronMargin: EdgeInsets.zero,
            ),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                // ------------------ FUTURE DAYS ------------------
                if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday || day.isAfter(DateTime.now())) {
                  return calendarMarker(
                    Colors.white,
                    Colors.grey.withValues(alpha: 0.5),
                    day,
                    // textColor: Colors.black.withValues(alpha: 0.6),
                    textColor: AppColors.textSecondary,
                  );
                }

                // ------------------ ABSENCE DAYS ------------------
                final absences = _getAbsencesForDay(day);
                if (absences.isNotEmpty) {
                  return calendarMarker(AppColors.absenceDayMarker, null, day);
                }

                // ------------------ ABSENCE DAYS ------------------
                return calendarMarker(color.primary, null, day);
              },
              // ------------------ SELECTED DAYS ------------------
              selectedBuilder: (context, day, focusedDay) {
                final absences = _getAbsencesForDay(day);
                Color bgColor;
                if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
                  bgColor = Colors.grey.shade300;
                } else if (absences.isNotEmpty) {
                  bgColor = Colors.red;
                } else {
                  bgColor = color.primary;
                }
                return calendarMarker(bgColor, null, day);
              },
              // ------------------ CURRENT DAYS ------------------
              todayBuilder: (context, day, focusedDay) {
                final absences = _getAbsencesForDay(day);
                Color bgColor;
                if (day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
                  bgColor = Colors.grey.shade300;
                } else if (absences.isNotEmpty) {
                  bgColor = Colors.red.withValues(alpha: 0.7);
                } else {
                  bgColor = color.primary.withValues(alpha: 0.7);
                }
                return calendarMarker(bgColor, bgColor, day);
              },
            ),
            // eventLoader: _getAbsencesForDay,
          ),
        ],
      ),
    );
  }

  Widget calendarMarker(
    Color bgColor,
    Color? borderColor,
    DateTime day, {
    Color textColor = Colors.white,
  }) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: borderColor != null ? Border.all(color: borderColor, width: 1) : null,
        ),
        width: 30.0,
        height: 30,
        child: Center(
          child: Text(
            '${day.day}',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    final color = Theme.of(context).colorScheme;
    final topPadding = MediaQuery.of(context).padding.top + 85;
    final localization = S.of(context);

    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(38),
        right: Radius.circular(38),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: topPadding,
        decoration: BoxDecoration(color: color.primaryContainer),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  localization.welcome,
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
