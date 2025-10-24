import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_app/core/extension/size_extension.dart';
import 'package:employee_app/core/theme/app_theme.dart';
import 'package:employee_app/widgets/box_shadow/common_box_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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

  late List<Map<String, dynamic>> _companyItems;
  late List<Map<String, dynamic>> _helpDeskItems;
  late List<Map<String, dynamic>> _recruimentItems;
  bool _itemsInitialized = false;

  bool _hasScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_itemsInitialized) {
      _initializeItems();
      _itemsInitialized = true;
    }
  }

  void _initializeItems() {
    final localization = S.of(context);

    _companyItems = [
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
        'icon': AppImageConstant.homeCompanyEvent,
        'label': localization.event,
        'path': '/event',
      },
    ];

    _helpDeskItems = [
      {
        'icon': AppImageConstant.homeHelpIT,
        'label': localization.ticketIT,
        'path': '/ticket_it',
      },
      {
        'icon': AppImageConstant.homeHelpRequest,
        'label': localization.createRequest,
        'path': '/create_request',
      },
      {
        'icon': AppImageConstant.homeHelpDevice,
        'label': localization.requestDevice,
        'path': '/request_device',
      },
    ];

    _recruimentItems = [
      {
        'icon': AppImageConstant.homeRecReferral,
        'label': localization.referral,
        'path': '/referral',
      },
      {
        'icon': AppImageConstant.homeRecInterview,
        'label': localization.interviewCalendar,
        'path': '/interview_calendar',
      },
      {
        'icon': AppImageConstant.homeRecCheckList,
        'label': localization.onboardChecklist,
        'path': '/onboard_checklist',
      },
      {
        'icon': AppImageConstant.homeRecRecall,
        'label': localization.offboarding,
        'path': '/offboarding',
      },
    ];
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
      _calendarFormat = _calendarFormat == CalendarFormat.week ? CalendarFormat.month : CalendarFormat.week;
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
            _ActionListTile(
              title: localization.scanQR,
              icon: Icons.qr_code,
              onTap: () {},
            ),
            _ActionListTile(
              title: localization.checkin,
              svgIcon: AppImageConstant.checkin,
              onTap: () {},
            ),
            _ActionListTile(
              title: localization.leaveRequest,
              svgIcon: AppImageConstant.calendar,
              onTap: () {},
            ),
            _ActionListTile(
              title: localization.createTicket,
              svgIcon: AppImageConstant.request,
              onTap: () {},
            ),
            SizedBox(height: 15.0.h()),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_itemsInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final localization = S.of(context);

    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          cacheExtent: 600,
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: PinnedHeaderDelegate(
                maxHeight: 150,
                minHeight: 150,
                child: _topBar(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
            SliverToBoxAdapter(child: _calendarView()),
            const SliverToBoxAdapter(child: SizedBox(height: 15.0)),
            SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _absenceView(),
                  _attendanceView(),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 15.0)),
            SliverToBoxAdapter(child: _incompleteTaskView()),
            const SliverToBoxAdapter(child: SizedBox(height: 15.0)),
            _functionListTitle(localization.aboutCompany),
            _buildFunctionGrid(_companyItems),
            // _functionListTitle('Helpdesk'),
            // _buildFunctionGrid(_helpDeskItems),
            // _functionListTitle('Nhân sự'),
            // _buildFunctionGrid(_recruimentItems),
            // SliverToBoxAdapter(child: _incomingEventView()),
            const SliverToBoxAdapter(child: SizedBox(height: 25.0)),
          ],
        ),
        _quickActionButton(),
      ],
    );
  }

  Widget _buildFunctionGrid(List<Map<String, dynamic>> items) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      sliver: DecoratedSliver(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: commonBoxShadow,
        ),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = items[index];
              return _GridItem(
                key: ValueKey('${item['path']}_$index'),
                icon: item['icon'],
                label: item['label'],
                path: item['path'],
              );
            },
            childCount: items.length,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _functionListTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 3.0, top: 10),
        child: Text(
          title,
          style: AppTextTheme.body2Bold.copyWith(color: AppColors.textPrimaryLight),
        ),
      ),
    );
  }

  Widget _quickActionButton() {
    final color = Theme.of(context).colorScheme;

    return Positioned(
      bottom: 10,
      right: 10,
      child: IconButton(
        splashRadius: 30,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color.primaryContainer),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0.r()),
          )),
          elevation: const WidgetStatePropertyAll<double>(3),
          shadowColor: const WidgetStatePropertyAll<Color>(Colors.grey),
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

  Widget _incomingEventView() {
    final localization = S.of(context);

    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              localization.incomingEvent,
              style: AppTextTheme.body2Bold.copyWith(color: AppColors.textPrimaryLight),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 140,
                  height: 280,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('sdf'),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }

  Widget _incompleteTaskView() {
    final localization = S.of(context);

    return RepaintBoundary(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: commonBoxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
            // Using Column instead of ListView for better performance with few items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text('Task $index', style: AppTextTheme.label2Regular),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Widget _attendanceView() {
    final localization = S.of(context);

    return Expanded(
      child: RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(right: 12, left: 6),
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
              const SizedBox(height: 10),
              _AttendanceInfo(
                label: localization.attendanceDate,
                value: '15/10/2025',
              ),
              const SizedBox(height: 5),
              _AttendanceInfo(
                label: localization.checkInTime,
                value: '08:59:05',
              ),
              const SizedBox(height: 5),
              _AttendanceInfo(
                label: localization.checkOutTime,
                value: '18:00:01',
              ),
              const SizedBox(height: 5),
              _AttendanceInfo(
                label: localization.checkInLocation,
                value: 'PK. Lê Thanh Nghị - 266 Lê Thanh Nghị',
                maxLines: 3,
                valueStyle: AppTextTheme.label1Bold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _absenceView() {
    final localization = S.of(context);

    return Expanded(
      child: RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(left: 12, right: 6),
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
              const Expanded(
                child: _OptimizedAbsenceCircle(
                  usedDays: 2.0,
                  totalDays: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calendarView() {
    final localization = S.of(context);

    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 10),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: commonBoxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CalendarHeader(
              title: localization.workDay,
              calendarFormat: _calendarFormat,
              onFormatToggle: _onChangeCalendarFormat,
            ),
            _OptimizedCalendar(
              calendarFormat: _calendarFormat,
              selectedDay: _selectedDay,
              focusedDay: _focusedDay,
              absences: _absences,
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
            ),
          ],
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
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(38),
        right: Radius.circular(38),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        height: topPadding,
        decoration: BoxDecoration(color: color.primaryContainer),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppImageConstant.notification,
                width: 30,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(color.primary, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 5),
            const CircleAvatar(
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

// Extract stateless widgets for better performance
class _GridItem extends StatelessWidget {
  final String icon;
  final String label;
  final String path;

  const _GridItem({
    super.key,
    required this.icon,
    required this.label,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            // context.goNamed(path);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                width: 32.0.w(),
              ),
              SizedBox(height: 7.0.h()),
              Text(
                label,
                style: AppTextTheme.caption2Bold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarMarker extends StatelessWidget {
  final Color bgColor;
  final Color? borderColor;
  final DateTime day;
  final Color textColor;

  const _CalendarMarker({
    super.key,
    required this.bgColor,
    this.borderColor,
    required this.day,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: borderColor != null ? Border.all(color: borderColor!, width: 1) : null,
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
}

class _AttendanceInfo extends StatelessWidget {
  final String label;
  final String value;
  final int maxLines;
  final TextStyle? valueStyle;

  const _AttendanceInfo({
    required this.label,
    required this.value,
    this.maxLines = 1,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: AppTextTheme.caption2Regular,
        children: [
          TextSpan(
            text: '\n $value',
            style: valueStyle ?? AppTextTheme.body2Bold,
          ),
        ],
      ),
      textAlign: TextAlign.start,
      maxLines: maxLines + 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ActionListTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? svgIcon;
  final VoidCallback onTap;

  const _ActionListTile({
    required this.title,
    this.icon,
    this.svgIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: AppTextTheme.body1Regular,
      ),
      trailing: icon != null
          ? Icon(icon, color: AppColors.textPrimaryLight)
          : SvgPicture.asset(
              svgIcon!,
              width: 25,
              colorFilter: ColorFilter.mode(AppColors.textPrimaryLight, BlendMode.srcIn),
            ),
      onTap: onTap,
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final String title;
  final CalendarFormat calendarFormat;
  final VoidCallback onFormatToggle;

  const _CalendarHeader({
    required this.title,
    required this.calendarFormat,
    required this.onFormatToggle,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextTheme.body2Bold.copyWith(color: AppColors.textPrimaryLight),
        ),
        IconButton(
          onPressed: onFormatToggle,
          icon: Icon(
            calendarFormat == CalendarFormat.week ? Icons.arrow_drop_down_circle_rounded : Icons.arrow_drop_up_rounded,
            color: color.primary,
            size: 30,
          ),
        )
      ],
    );
  }
}

class _OptimizedAbsenceCircle extends StatelessWidget {
  final double usedDays;
  final double totalDays;

  const _OptimizedAbsenceCircle({
    required this.usedDays,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    final remainingDays = (totalDays - usedDays).clamp(0, totalDays);
    final progress = (usedDays / totalDays).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide * 0.9;

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- Circle progress ---
              SizedBox(
                width: size,
                height: size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: Size(size, size),
                      painter: _CircularProgressPainter(
                        progress: progress,
                        strokeWidth: 14,
                        backgroundColor: AppColors.blue400,
                        gradientColors: [
                          Colors.grey.shade100,
                          Colors.grey.shade200,
                          Colors.grey.shade300,
                          Colors.grey.shade400,
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${usedDays.toStringAsFixed(1)}',
                                style: AppTextTheme.display1Bold.copyWith(
                                  color: AppColors.textPrimaryLight,
                                  fontSize: 32,
                                ),
                              ),
                              TextSpan(
                                text: '\n/ ${totalDays.toInt()}',
                                style: AppTextTheme.caption1Bold.copyWith(
                                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'ngày phép',
                          style: AppTextTheme.caption2Regular.copyWith(
                            color: AppColors.textSecondary.withValues(alpha: 0.7),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              RichText(
                text: TextSpan(
                  text: localization.remain,
                  style: AppTextTheme.label2Regular.copyWith(color: AppColors.textSecondary),
                  children: [
                    TextSpan(
                      text: '10.0',
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
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final List<Color> gradientColors;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);

      final gradientPaint = Paint()
        ..shader = SweepGradient(
          colors: gradientColors,
          startAngle: -90 * 3.14159 / 180,
          endAngle: (-90 + 360 * progress) * 3.14159 / 180,
        ).createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      const startAngle = -90 * 3.14159 / 180;
      final sweepAngle = 360 * progress * 3.14159 / 180;

      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle,
        false,
        gradientPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.backgroundColor != backgroundColor;
  }

  @override
  bool shouldRebuildSemantics(_CircularProgressPainter oldDelegate) => false;
}

class _OptimizedCalendar extends StatefulWidget {
  final CalendarFormat calendarFormat;
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final Map<DateTime, List<String>> absences;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;

  const _OptimizedCalendar({
    required this.calendarFormat,
    required this.selectedDay,
    required this.focusedDay,
    required this.absences,
    required this.onDaySelected,
    required this.onFormatChanged,
  });

  @override
  State<_OptimizedCalendar> createState() => _OptimizedCalendarState();
}

class _OptimizedCalendarState extends State<_OptimizedCalendar> {
  late final DateTime _today;

  final Map<int, bool> _weekendCache = {};

  final Map<String, bool> _absenceCache = {};

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
  }

  bool _isWeekend(DateTime day) {
    final key = day.weekday;
    return _weekendCache.putIfAbsent(
      key,
      () => key == DateTime.saturday || key == DateTime.sunday,
    );
  }

  bool _hasAbsence(DateTime day) {
    final key = '${day.year}-${day.month}-${day.day}';
    return _absenceCache.putIfAbsent(key, () {
      final normalized = DateTime(day.year, day.month, day.day);
      return widget.absences.containsKey(normalized) && widget.absences[normalized]!.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.monday,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: widget.focusedDay,
      headerVisible: true,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        formatButtonShowsNext: false,
        titleCentered: true,
        titleTextFormatter: (date, locale) {
          return DateFormat('MM/yyyy').format(date);
        },
        titleTextStyle: AppTextTheme.body1Bold.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headerPadding: const EdgeInsets.only(top: 5),
        leftChevronMargin: EdgeInsets.zero,
        rightChevronMargin: EdgeInsets.zero,
      ),
      calendarFormat: widget.calendarFormat,
      selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
      onDaySelected: widget.onDaySelected,
      onFormatChanged: widget.onFormatChanged,
      calendarStyle: const CalendarStyle(),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) {
          // Use cached checks
          final isWeekend = _isWeekend(day);
          final isFuture = day.isAfter(_today);
          final hasAbsence = _hasAbsence(day);

          if (isWeekend || isFuture) {
            return _CalendarMarker(
              key: ValueKey('default_${day.day}_${day.month}'),
              bgColor: Colors.white,
              borderColor: Colors.grey.withValues(alpha: 0.5),
              day: day,
              textColor: AppColors.textSecondary,
            );
          }

          if (hasAbsence) {
            return _CalendarMarker(
              key: ValueKey('absence_${day.day}_${day.month}'),
              bgColor: AppColors.absenceDayMarker,
              day: day,
            );
          }

          return _CalendarMarker(
            key: ValueKey('work_${day.day}_${day.month}'),
            bgColor: color.primary,
            day: day,
          );
        },
        selectedBuilder: (context, day, focusedDay) {
          final isWeekend = _isWeekend(day);
          final hasAbsence = _hasAbsence(day);

          Color bgColor;
          if (isWeekend) {
            bgColor = Colors.grey.shade300;
          } else if (hasAbsence) {
            bgColor = Colors.red;
          } else {
            bgColor = color.primary;
          }

          return _CalendarMarker(
            key: ValueKey('selected_${day.day}_${day.month}'),
            bgColor: bgColor,
            day: day,
          );
        },
        todayBuilder: (context, day, focusedDay) {
          final isWeekend = _isWeekend(day);
          final hasAbsence = _hasAbsence(day);

          Color bgColor;
          if (isWeekend) {
            bgColor = Colors.grey.shade300;
          } else if (hasAbsence) {
            bgColor = Colors.red.withValues(alpha: 0.7);
          } else {
            bgColor = color.primary.withValues(alpha: 0.7);
          }

          return _CalendarMarker(
            key: ValueKey('today_${day.day}'),
            bgColor: bgColor,
            borderColor: bgColor,
            day: day,
          );
        },
      ),
    );
  }
}
