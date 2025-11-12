import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:green_care/pages/auth/login_page.dart';
import 'package:green_care/routes/router_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'GreenCare',
      initialRoute: RouterHelper.login,
      getPages: RouterHelper.routes,
    );
  }
}
