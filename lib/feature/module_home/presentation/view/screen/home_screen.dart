import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/core/extension/size_extension.dart';
import 'package:employee_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/constant/app_image_constant.dart';
import '../../../../../core/constant/app_text_constant.dart';
import '../../../../../core/theme/text_theme.dart';
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

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context).colorScheme;
    // final color = Theme.of(context).colorScheme;
    //
    // DateTime now = DateTime.now();
    // DateTime date = DateTime(now.year, now.month, now.day);

    return CustomScrollView(
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
        _calendarView(),
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
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue900.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
                BoxShadow(
                  color: AppColors.blue500.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
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
                        'Các task chưa hoàn thành',
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
                      child: Text('Task $index'),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: 5,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 15.0)),
      ],
    );
  }

  Widget _attendanceView() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(right: 12, left: 6),
        height: 230.0.h(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.blue900.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.blue500.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dữ liệu chấm công',
              style: AppTextTheme.body2Bold.copyWith(color: AppColors.textPrimaryLight),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: 'Ngày chấm công: ',
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
                text: 'Thời gian vào: ',
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
                text: 'Thời gian ra: ',
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
                text: 'Địa điểm chấm công: ',
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
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(left: 12, right: 6),
        height: 230.0.h(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.blue900.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.blue500.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Số ngày nghỉ phép',
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
                              text: '/ \n12 ngày',
                              style: AppTextTheme.caption1Bold.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 35.0.h()),
                      RichText(
                        text: TextSpan(
                          text: 'Còn lại ',
                          style: AppTextTheme.label2Regular.copyWith(color: AppColors.textSecondary),
                          children: [
                            TextSpan(
                              text: '11.0',
                              style: AppTextTheme.body2Bold.copyWith(color: AppColors.absenceDayMarker),
                            ),
                            TextSpan(
                              text: ' ngày',
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

  SliverToBoxAdapter _calendarView() {
    final color = Theme.of(context).colorScheme;
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 10),
        margin: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.blue900.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.blue500.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Số ngày công',
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
                  if (day.weekday == DateTime.saturday ||
                      day.weekday == DateTime.sunday ||
                      day.isAfter(DateTime.now())) {
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

  Material _topBar() {
    final color = Theme.of(context).colorScheme;
    final topPadding = MediaQuery.of(context).padding.top + 85;

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
