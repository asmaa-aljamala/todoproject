import 'package:flutter/material.dart';
import 'package:todo/provider.dart';
import 'package:todo/todo.dart';


class SplachScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<DatabaseProvider>(context, listen: false).getAllTasks();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return TodoApp();
      }));
    });
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(),
    );
  }
}
