import 'package:anime_list/app.dart';
import 'package:anime_list/core/di/injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await configureDependencies();

  runApp(const MyApp());
}
