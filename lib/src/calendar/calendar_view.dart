import 'package:dayblocks_mobile/src/calendar/week_calendar.dart';
import 'package:dayblocks_mobile/src/settings/settings_controller.dart';
import 'package:dayblocks_mobile/src/task/task_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../settings/settings_view.dart';
import '../sample_feature/sample_item.dart';
import '../sample_feature/sample_item_details_view.dart';

/// Displays a list of SampleItems.
class CalendarView extends StatefulWidget {
  const CalendarView({
    super.key,
    required this.controller,
  });

  static const routeName = '/';

  final SettingsController controller;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final DraggableScrollableController bottomSheetController =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(DateFormat.yMMMM('ko-KR').format(DateTime.now())),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: Stack(children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: WeekCalendar(
                referenceDate: DateTime.now(),
                startOfWeek: widget.controller.startOfWeek,
              )),
          DraggableScrollableSheet(
              initialChildSize: 0.12,
              minChildSize: 0.12,
              maxChildSize: 0.5,
              snap: true,
              snapSizes: const [0.12, 0.5],
              shouldCloseOnMinExtent: false,
              controller: bottomSheetController,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                    controller: scrollController,
                    child: TaskList(scrollController, ));
              })
        ]));
  }
}
