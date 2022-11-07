import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/init_dependency.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: InitDep(),
        theme: ThemeData(primaryColor: Colors.purple[900]),
        home: HomePage());
  }
}
