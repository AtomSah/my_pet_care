import 'package:pet_care/app/app.dart';
import 'package:pet_care/app/di/di.dart';
import 'package:pet_care/core/network/hive_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService().init();

  await initDependencies();
  runApp(const MyApp());
}
