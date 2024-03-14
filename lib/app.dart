import 'package:anime_list/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'screens/anime/view/anime_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: ApplicationConstants.debugMode,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimeView(),
    );
  }
}
