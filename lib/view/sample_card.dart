import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/appointments_card_data.dart';

class CardItem extends StatelessWidget {
  final CardData cardData;

  CardItem({required this.cardData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 85,
      child: Card(
        child: ListTile(
          tileColor: Colors.blue[50],
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text(
            cardData.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            DateFormat('hh:mm a').format(cardData.date),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}