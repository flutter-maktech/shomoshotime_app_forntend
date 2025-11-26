import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/spi_practice_bank_and_controller.dart';

class SpiPracticeBankAndView extends GetView<SpiPracticeBankAndController> {
  const SpiPracticeBankAndView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpiPracticeBankAndView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SpiPracticeBankAndView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
