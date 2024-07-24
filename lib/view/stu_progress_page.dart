import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:license/res/colors.dart';
import '../view_model/stu_progress_cards.dart';

class CardListView extends StatelessWidget {
  final String userId;

  CardListView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = CardListViewModel(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text('My progress'),
      ),
      body: FutureBuilder<List<CardViewData>>(
        future: viewModel.getCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No progress data available'));
          }

          final cards = snapshot.data!;

          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Container(
                    width: 330,
                    height: 110,
                    color: Colors.white,
                    child: Center(
                      child: GFListTile(
                        avatar: GFAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(card.avatarUrl),
                          shape: GFAvatarShape.square,
                          size: 50,
                        ),
                        titleText: card.title,
                        subTitleText: card.subtitle,
                        icon: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            value: card.progress,
                            color: AppColors.primary,
                            backgroundColor: AppColors.secondaryBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
