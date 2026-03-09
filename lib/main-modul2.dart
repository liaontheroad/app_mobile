import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test4me/modul_3/providers/dashboard_provider.dart';
import 'package:test4me/modul_3/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: MaterialApp(
        title: 'Dashboard App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const DashboardPage(),
      ),
    );
  }
}