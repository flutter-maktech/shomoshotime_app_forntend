import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/study_guides_controller.dart';

class StudyGuidesView extends GetView<StudyGuidesController> {
  const StudyGuidesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyGuidesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudyGuidesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
