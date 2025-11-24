import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/enter_code_controller.dart';

class EnterCodeView extends GetView<EnterCodeController> {
  const EnterCodeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EnterCodeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EnterCodeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
