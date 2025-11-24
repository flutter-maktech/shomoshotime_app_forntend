import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Continue Learning",
        subTitle: "Pick up where you left off",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: []),
      ),
    );
  }
}
