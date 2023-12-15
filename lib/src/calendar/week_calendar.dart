import 'package:dayblocks_mobile/src/calendar/utils.dart';
import 'package:dayblocks_mobile/src/calendar/week_day.dart';
import 'package:flutter/material.dart';

class WeekCalendar extends StatelessWidget {
  const WeekCalendar({required this.referenceDate, required this.startOfWeek, super.key});

  final DateTime referenceDate;
  final int startOfWeek;

  @override
  Widget build(BuildContext context) {
    final DateTime startOfWeekDate = mostRecentWeekday(referenceDate, startOfWeek);

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for(int i = 0; i < 7; i++) WeekDay(date: startOfWeekDate.add(Duration(days: i)))
          ]
        )
      ),
    );
  }
}