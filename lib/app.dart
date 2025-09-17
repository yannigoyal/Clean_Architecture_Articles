import 'package:clean_architecture_articles/features/article/presentation/pages/disliked_page.dart';
import 'package:clean_architecture_articles/features/article/presentation/pages/home_page.dart';
import 'package:clean_architecture_articles/features/article/presentation/pages/liked_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Swipe (Clean Architecture + BLoC)',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => HomePage(),
        '/liked': (_) => LikedPage(),
        '/disliked': (_) => DislikedPage(),
      },
    );
  }
}
