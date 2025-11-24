import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/forgot_password_2_controller.dart';

class ForgotPassword2View extends GetView<ForgotPassword2Controller> {
  const ForgotPassword2View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForgotPassword2View'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ForgotPassword2View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
