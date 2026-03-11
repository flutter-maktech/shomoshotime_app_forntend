import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../data/image_path.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      body: Center(child: Image.asset(ImagePath.appLogo, height: 100)),
    );
  }
}
