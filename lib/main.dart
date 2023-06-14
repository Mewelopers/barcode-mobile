import 'package:flutter/material.dart';
import 'di/injectable.dart';
import 'screens/list_of_lists/list_of_lists.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Dependency injection (injectable)
  await configureDependencies();

  runApp(MaterialApp(
      title: 'Navigation Basics',
      home: const ListOfLists(),
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        }),
      )));
}
