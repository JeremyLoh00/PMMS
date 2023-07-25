import 'dart:async';
import 'dart:collection';
import 'dart:ui';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:intl/intl.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/store_job_form_bloc.dart';
import 'package:private_nurse_for_client/public_components/loading_dialog.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateJobInfo extends StatefulWidget {
  StoreJobFormBloc storeJobFormBloc;
  Set<DateTime> selectedDays;
  CreateJobInfo({
    super.key,
    required this.storeJobFormBloc,
    required this.selectedDays,
  });

  @override
  State<CreateJobInfo> createState() => _CreateJobInfoState();
}

class _CreateJobInfoState extends State<CreateJobInfo> {
  String? _service;
  TextEditingController date = TextEditingController();
  final format = DateFormat('HH:mm');

  final serviceList = [
    'Wound Dressing',
    'Daycare Service',
    'Live-in service',
    'Feeding Tube Insertion/Removal/Exchange',
    'Urinal tube insertion/Removal/Exchange',
    'Physiotheraphy',
  ];

  int delayAnimationDuration = 200;
  late final ValueNotifier<List<Event>> _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());

  late PageController _pageController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    widget.selectedDays.add(_focusedDay.value);
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  bool get canClearSelection =>
      widget.selectedDays.isNotEmpty ||
      _rangeStart != null ||
      _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return _getEventsForDays(days);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (widget.selectedDays.contains(selectedDay)) {
        widget.selectedDays.remove(selectedDay);
        String dateId = selectedDay.day.toString() +
            "-" +
            selectedDay.month.toString() +
            "-" +
            selectedDay.year.toString();
        widget.storeJobFormBloc.removeVariant(dateId);
      } else {
        widget.selectedDays.add(selectedDay);
        String dateId = selectedDay.day.toString() +
            "-" +
            selectedDay.month.toString() +
            "-" +
            selectedDay.year.toString();
        widget.storeJobFormBloc.addVariant(dateId);
      }

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    _selectedEvents.value = _getEventsForDays(widget.selectedDays);
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _focusedDay.value = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      widget.selectedDays.clear();
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => StoreJobFormBloc(),
        child: Builder(
          builder: (context) {
            final storeJobForm = BlocProvider.of<StoreJobFormBloc>(context);

            return FormBlocListener<StoreJobFormBloc, String, String>(
              // On submitting
              onSubmitting: ((context, state) {
                FocusScope.of(context).unfocus();
                LoadingDialog.show(context);
                if (kDebugMode) {
                  print("hai");
                }
              }),
              //On Submission Failed
              onSubmissionFailed: (context, state) {
                LoadingDialog.hide(context);
              },
              // On Success
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
              },
              // On failure
              onFailure: (context, state) {
                LoadingDialog.hide(context);
                ThemeSnackBar.showSnackBar(
                    context, state.failureResponse ?? "Error");
              },
              // Design
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DelayedDisplay(
                    delay: Duration(milliseconds: delayAnimationDuration),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Service",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Space(20),
                        Container(
                          width: double.infinity,
                          child: DropdownButtonFormField(
                            hint: const Text("Select Service"),
                            value: _service,
                            onChanged: (String? newValue) {
                              setState(() {
                                _service = newValue ?? "";
                              });
                            },
                            items: _serviceList(),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 3,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Space(20),
                  DelayedDisplay(
                    delay: Duration(milliseconds: delayAnimationDuration),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Job Date",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Space(10),
                            Container(
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  profileShadow(
                                    kGrey.withOpacity(0.3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  ValueListenableBuilder<DateTime>(
                                    valueListenable: _focusedDay,
                                    builder: (context, value, _) {
                                      return _CalendarHeader(
                                        focusedDay: value,
                                        clearButtonVisible: canClearSelection,
                                        onTodayButtonTap: () {
                                          setState(() => _focusedDay.value =
                                              DateTime.now());
                                        },
                                        onClearButtonTap: () {
                                          setState(() {
                                            _rangeStart = null;
                                            _rangeEnd = null;
                                            widget.selectedDays.clear();
                                            _selectedEvents.value = [];
                                          });
                                        },
                                        onLeftArrowTap: () {
                                          _pageController.previousPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        },
                                        onRightArrowTap: () {
                                          _pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  TableCalendar<Event>(
                                    firstDay: kFirstDay,
                                    lastDay: kLastDay,
                                    focusedDay: _focusedDay.value,
                                    headerVisible: false,
                                    selectedDayPredicate: (day) {
                                      return widget.selectedDays.contains(day);
                                    },
                                    rangeStartDay: _rangeStart,
                                    rangeEndDay: _rangeEnd,
                                    calendarFormat: _calendarFormat,
                                    rangeSelectionMode: _rangeSelectionMode,
                                    // eventLoader: _getEventsForDay,
                                    // holidayPredicate: (day) {
                                    //   // Every 20th day of the month will be treated as a holiday
                                    //   return day.day == 20;
                                    // },
                                    onDaySelected: _onDaySelected,
                                    onRangeSelected: _onRangeSelected,
                                    onCalendarCreated: (controller) =>
                                        _pageController = controller,
                                    onPageChanged: (focusedDay) =>
                                        _focusedDay.value = focusedDay,
                                    onFormatChanged: (format) {
                                      if (_calendarFormat != format) {
                                        setState(
                                            () => _calendarFormat = format);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _serviceList() {
    return serviceList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          SizedBox(
            width: 120.0,
            child: Text(
              headerText,
              style: TextStyle(fontSize: 26.0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, size: 20.0),
            visualDensity: VisualDensity.compact,
            onPressed: onTodayButtonTap,
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: onLeftArrowTap,
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}
