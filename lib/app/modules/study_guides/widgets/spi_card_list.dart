import 'package:flutter/material.dart';

import 'spi_fundamentals_card.dart';

class SpiCardList extends StatelessWidget {
  const SpiCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SpiFundamentalsCard(
            timeText: '9 hours',
            chapterText: '5/12 Chapters',
            progressPercentText: '75%',
            progressValue: 0.75,
          ),
        );
      }, childCount: 4),
    );
  }
}