import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/provider.dart';
import 'package:todo/todo_widget.dart';

import 'new_task.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NewTaskPage();
            }));
          },
        ),
        appBar: AppBar(
          title: Text('TodoApp'),
          bottom: TabBar(tabs: [
            Tab(
              child: Text('All Tasks'),
            ),
            Tab(
              child: Text('Complete Tasks'),
            ),
            Tab(
              child: Text('InComplete Tasks'),
            )
          ]),
        ),
        body: Consumer<DatabaseProvider>(
          builder: (context, value, child) {
            return TabBarView(children: [
              Column(
                children: value.tasks.map((e) => TodoWidget(e)).toList(),
              ),
              Column(
                children:
                    value.completeTasks.map((e) => TodoWidget(e)).toList(),
              ),
              Column(
                children:
                    value.inCompleteTasks.map((e) => TodoWidget(e)).toList(),
              )
            ]);
          },
        ),
      ),
      length: 3,
    );
  }
}
