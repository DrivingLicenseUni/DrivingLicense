import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:license/res/colors.dart';
import 'package:license/view_model/stu_progress_cards.dart';


class CardListView extends StatelessWidget {
  final CardListViewModel viewModel = CardListViewModel();
   CardListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: viewModel.getCards().length,
      itemBuilder: (context, index) {
        final card = viewModel.getCards()[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Set radius to zero
            ),
            child: Container(
              width: 330,
              height: 110,
              color: Colors.white,
              child: Center(
                child: GFListTile(

                  avatar: GFAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage:AssetImage(card.avatarUrl) as ImageProvider,
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
                      color:AppColors.primary ,
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
  }
}