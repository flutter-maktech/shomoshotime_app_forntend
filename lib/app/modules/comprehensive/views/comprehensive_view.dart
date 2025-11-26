import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/comprehensive_controller.dart';

class ComprehensiveView extends GetView<ComprehensiveController> {
  const ComprehensiveView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ComprehensiveView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ComprehensiveView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
