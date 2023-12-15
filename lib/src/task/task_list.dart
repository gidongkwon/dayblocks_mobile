import 'package:flutter/material.dart';

import 'task.dart';

class _DraggingHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
    );
  }
}

class _DraggingTaskIndicator extends StatelessWidget {
  _DraggingTaskIndicator({ required this.data, required this.dragKey, });

  final GlobalKey dragKey;
  final Task data;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0, -0),
      child: ClipRRect(
        key: dragKey,
        child: Opacity(
        opacity: 0.85,
        child: Text(data.title, style: Theme.of(context).textTheme.bodyMedium),
      ),
      ),
    );
  }

}

class TaskList extends StatefulWidget {
  TaskList(this.scrollController, {super.key});

  ScrollController scrollController;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final List<Task> _tasks = [];
  final GlobalKey _draggableKey = GlobalKey();

  void _showAddSheet(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '할 일 추가',
                  style: TextStyle(fontSize: 18.0),
                ),
                TextField(
                  controller: textFieldController,
                  decoration: const InputDecoration(
                    hintText: '제목 입력',
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _tasks.add(Task(
                              id: DateTime.now().toString(),
                              title: textFieldController.text,
                              isDone: false));
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
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 12,
      child: Container(
        height: 380,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            _DraggingHandle(),
            Column(
              children: [
                const SizedBox(height: 12),
                ListView(
                    controller: widget.scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children:
                        _tasks.map((e) => LongPressDraggable<Task>(
                          data: e,
                            feedback: _DraggingTaskIndicator(data: e, dragKey: _draggableKey,),
                            child: ListTile(
                            title: Text(e.title),
                          trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => {
                            setState(() {
                              _tasks.removeWhere((element) => element.id == e.id);
                            })
                          },),
                        ))).toList()),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          _showAddSheet(context);
                        },
                        child: Text('할 일 추가')
                    ),
                    const SizedBox(width: 12)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
