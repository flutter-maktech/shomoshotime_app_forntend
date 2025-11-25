import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_otp_controller.dart';

class SignUpOtpView extends GetView<SignUpOtpController> {
  const SignUpOtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUpOtpView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SignUpOtpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
