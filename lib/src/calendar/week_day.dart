import 'package:dayblocks_mobile/src/calendar/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dayblock.dart';

class WeekDay extends StatelessWidget {
  const WeekDay({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Column(
        children: [
          Text(DateFormat('E').format(date), style: Theme.of(context).textTheme.titleSmall?.copyWith(color: date.isToday ? Colors.blue : null)),
          const SizedBox(height: 6),
          Text(DateFormat('dd').format(date), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: date.isToday ? Colors.blue : null)),
        ],
      ),
      Expanded(
        flex: 1,
        child: Column(
          children: [
            for (int i = 0; i < 6; i++) Expanded(flex: 1, child: Dayblock(index: i, date: date)),
          ]
        ),
      ),
      const SizedBox(height: 100)
    ]);
  }
}
