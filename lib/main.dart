import 'package:best_way_tracker/di.dart' as di;
import 'package:best_way_tracker/presentation/page/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await di.init();
  runApp(const MaterialApp(home: HomeScreen()));
}
