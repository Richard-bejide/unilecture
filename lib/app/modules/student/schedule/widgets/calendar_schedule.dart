import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_im_animations/im_animations.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uni_lecture/app/shared/utils/colors.dart';
import 'dart:collection';

import '../../../../routes/app_pages.dart';
import '../../../../shared/utils/text_style.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({super.key});

  @override
  _ScheduleCalendarState createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode =
      RangeSelectionMode.toggledOff; // Can be toggled on/off by long pressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {CalendarFormat.month: 'Month', CalendarFormat.week: 'Week'},
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayTextStyle: const TextStyle(color: Colors.black),
              todayDecoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.kPrimaryColor, width: 1.5)),
              selectedDecoration: BoxDecoration(color: AppColors.kPrimaryColor, shape: BoxShape.circle),
              markerDecoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Class Schedule',
              style: AppText.boldText,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${value[index].startTime} - ${value[index].endTime}',
                              style: AppText.semiBoldText.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.5), width: 0.6)),
                              child: CircleAvatar(
                                backgroundColor: AppColors.kPrimaryColor.withOpacity(0.5),
                                radius: 5,
                              ),
                            ),
                            index != value.length - 1
                                ? Container(
                                    height: 70,
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.5),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: GestureDetector(
                            onTap:(){
                              //Get.toNamed(Routes.CLASS);
                              },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  value[index].isLive
                                      ? Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Sonar(
                                            radius: 12,
                                            waveColor: Colors.green,
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.green,
                                              radius: 4,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              'LIVE',
                                              style: AppText.boldText.copyWith(
                                                fontSize: 10,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 20,
                                        backgroundImage: AssetImage(value[index].teacherImage),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.37,
                                            child: Text(
                                              value[index].title,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppText.semiBoldText.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.37,
                                            child: Text(
                                              value[index].teacherName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppText.semiBoldText.copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  DateTime.utc(kToday.year, kToday.month, kToday.day): [
    const Event(
        title: 'Python Programming',
        teacherImage: 'assets/images/python.png',
        teacherName: 'Richard Bejide',
        startTime: '9:00am',
        endTime: '11:00am',
        isLive: true),
  ],
  DateTime.utc(kToday.year, kToday.month, kToday.day + 2): [
    const Event(
        title: 'Java Programming',
        teacherImage: 'assets/images/java.png',
        teacherName: 'Richard Bejide',
        startTime: '9:00am',
        endTime: '11:00am',
        isLive: false),
  ],
  DateTime.utc(kToday.year, kToday.month, kToday.day + 4): [
    const Event(
        title: 'Data Structures & Algorithms',
        teacherImage: 'assets/images/algo.png',
        teacherName: 'Richard Bejide',
        startTime: '9:00am',
        endTime: '11:00am',
        isLive: false),
  ]
};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month, 1);
final kLastDay = DateTime(kToday.year, kToday.month + 1, kToday.day);

class Event {
  final String title;
  final String teacherName;
  final String teacherImage;
  final String startTime;
  final String endTime;
  final bool isLive;

  const Event(
      {required this.title,
      required this.teacherImage,
      required this.teacherName,
      required this.startTime,
      required this.endTime,
      required this.isLive});
}
