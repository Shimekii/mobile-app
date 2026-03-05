import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app_root.dart';
import 'app/app_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Demo',
      home: AppRoot(),
    );
  }
}