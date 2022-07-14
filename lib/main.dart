import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/providers/dashboard_provider.dart';
import 'package:flutter_projects/core/providers/page_provider.dart';
import 'package:flutter_projects/features/dashboard/provider/tab_provider.dart';
import 'package:flutter_projects/features/tabs/view/tabs_view.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Sqflite.setDebugModeOn(true);
  openDatabase(
    'smoking_track.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE smokings (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, date TEXT,price DOUBLE)',
      );
      await db
          .execute(
        'CREATE TABLE smoking_price (id INTEGER PRIMARY KEY, price DOUBLE)',
      )
          .then((value) {
        db.insert("smoking_price", {"price": 1.5});
        log("db created");
      });
      await db.execute(
        'CREATE TABLE smoking_limit (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, smoking_limit INTEGER)',
      );
    },
  );
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
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
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
