import 'package:dayblocks_mobile/src/calendar/utils.dart';
import 'package:dayblocks_mobile/src/task/task.dart';
import 'package:flutter/material.dart';

class Dayblock extends StatefulWidget {
  Dayblock({super.key, required this.index, required this.date});

  final int index;
  final DateTime date;

  @override
  State<Dayblock> createState() => _DayblockState();
}

class _DayblockState extends State<Dayblock> {
  final Map<int, String> placeholders = {
    0: '오전',
    1: '오후',
    2: '저녁',
  };

  final Map<int, MaterialColor> colors = {
    0: Colors.orange,
    1: Colors.green,
    2: Colors.blue,
  };

  String blockTitle = '';
  final List<Task> _allocatedTasks = [];

  void _showEditSheet(BuildContext context) {
    TextEditingController textFieldController =
        TextEditingController(text: blockTitle);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '이 블록에서 집중할 일',
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: textFieldController,
                  decoration: InputDecoration(
                    hintText: blockTitle.isNotEmpty ? blockTitle : '제목 입력',
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          blockTitle = textFieldController.text;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('확인'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final blockIndex = (widget.index / 2).floor();
    final numberWithinRange = widget.index % 2 + 1;
    final placeholderText = '${placeholders[blockIndex]} $numberWithinRange';
    return DragTarget<Task>(
      builder: (context, candidates, rejectedItems) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _showEditSheet(context),
          child: SizedBox(
            width: widget.date.isToday ? 250 : 150,
            child: Card(
              elevation: 0,
              color: colors[blockIndex]?.shade50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Text(
                        blockTitle.isNotEmpty ? blockTitle : placeholderText,
                        style: TextStyle(color: colors[blockIndex]?.shade500, fontSize: 18, fontWeight: blockTitle.isNotEmpty ? FontWeight.bold : FontWeight.normal)),
                        ..._allocatedTasks.map((e) {
                          return OutlinedButton(onPressed: () {
                            setState(() {
                              _allocatedTasks.removeWhere((element) => element.id == e.id);
                            });
                        }, child: Text(e.title));
                      }).toList()
                  ],
                ),
              ),
            ),
          ),
        );
      },
      onAccept: (item) {
        setState(() {
          _allocatedTasks.add(item);
        });
      },
    );
  }
}
