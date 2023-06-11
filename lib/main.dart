import 'package:flutter/material.dart';
import 'di/injectable.dart';
import 'screens/list_of_lists/list_of_lists.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Dependency injection (injectable)
  await configureDependencies();

  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: ListOfLists(),
  ));
}
