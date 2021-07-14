

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/provider.dart';
import 'package:todo/tod_model.dart';

class TodoWidget extends StatelessWidget {
  Task task;
  TodoWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.taskName),
        leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<DatabaseProvider>().deleteTask(task);
            }),
        trailing: Checkbox(
          value: task.isComplete,
          onChanged: (value) {
            context.read<DatabaseProvider>().updateTask(task);
          },
        ),
      ),
    );
  }
}
