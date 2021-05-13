import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wmc_scan_master/ui/pages/login.dart';

Future<void> main() async {
  await GetStorage.init('scan_wmc_master');
  runApp(
    GetMaterialApp(
      title: "Sem Cancela Master",
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      home: LoginPage(),
      locale: Locale('pt', 'BR'),
    ),
  );
}
