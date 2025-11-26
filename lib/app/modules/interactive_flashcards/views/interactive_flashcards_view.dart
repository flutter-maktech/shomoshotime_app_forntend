import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/interactive_flashcards_controller.dart';

class InteractiveFlashcardsView
    extends GetView<InteractiveFlashcardsController> {
  const InteractiveFlashcardsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InteractiveFlashcardsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InteractiveFlashcardsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
