import 'package:flutter/material.dart';

import 'study_guide_card.dart';

class SpiAudioCardList extends StatelessWidget {
  const SpiAudioCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: StudyGuideCard(),
        );
      }, childCount: 4),
    );
  }
}
