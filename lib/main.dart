import 'package:do_it_today/screens/home.dart';
import 'package:do_it_today/screens/todos.dart';
import 'package:flutter/material.dart';
import 'package:do_it_today/providers/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? name;
  @override
  void initState() {
    super.initState();

    SaveUser.getUserName().then((value) => setState(() {
          name = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: Scaffold(
        body: name == null || name == "" ? const Home() : const Todos(),
      ),
    );
  }
}
