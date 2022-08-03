import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/database/sqflite_manager.dart';
import 'package:flutter_projects/core/providers/dashboard_provider.dart';
import 'package:flutter_projects/core/providers/page_provider.dart';
import 'package:flutter_projects/core/providers/timer_provider.dart';
import 'package:flutter_projects/features/dashboard/provider/tab_provider.dart';
import 'package:flutter_projects/features/tabs/view/tabs_view.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Sqflite.setDebugModeOn(true);
  SqfliteManager.executeDatabase(path: 'smoking_track.db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(
          create: (_) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TabProvider(),
        ),
        ChangeNotifierProvider(create: (_) => TimerProvider(isOpening: true)),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Quicksand",
            primarySwatch: Colors.blue,
          ),
          home: const TabsView(),
        );
      },
    );
  }
}
