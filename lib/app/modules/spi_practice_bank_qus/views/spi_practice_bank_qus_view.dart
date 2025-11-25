import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/spi_practice_bank_qus_controller.dart';

class SpiPracticeBankQusView extends GetView<SpiPracticeBankQusController> {
  const SpiPracticeBankQusView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpiPracticeBankQusView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SpiPracticeBankQusView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
