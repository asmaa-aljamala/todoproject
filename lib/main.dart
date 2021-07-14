import 'package:flutter/material.dart';
import 'package:todo/provider.dart';
import 'package:todo/splash.dart';
import 'package:todo/task_helper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpHelper.spHelper.initSharedPrefrences();
  await TaskDbHelper.taskDbHelper.initializeTasksDatabase();
  await translator.init(
      localeDefault: LocalizationDefaultType.device,
      languagesList: <String>['ar', 'en'],
      assetsDirectory: 'assets/langs/' // NOT YET TESTED
      );
  runApp(LocalizedApp(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (context) {
        return DatabaseProvider();
      },
      child: MaterialApp(
        home: SplachScreen(),
        localizationsDelegates: translator.delegates, // Android + iOS Delegates
        locale: translator.locale, // Active locale
        supportedLocales: translator.locals(),
      ),
    );
  }
}
