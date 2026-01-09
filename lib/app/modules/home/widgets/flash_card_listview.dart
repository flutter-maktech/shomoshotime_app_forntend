import 'package:flutter/material.dart';

import 'falsh_card_info.dart';

class FlashCardListView extends StatelessWidget {
  const FlashCardListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) => FlashCardInfo(
        flashCardTitle: 'Flash cards title here',
        flashCardSubtitle: 'Total chapter: 05',
      ),
    );
  }
}
