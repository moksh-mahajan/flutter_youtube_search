import 'package:flutter/material.dart';
import 'package:youtube_search/injection_container.dart';
import 'package:youtube_search/ui/search/search_page.dart';

void main() {
  initKiwi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Youtube Search',
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.red,
            accentColor: Colors.redAccent),
        home: SearchPage());
  }
}
