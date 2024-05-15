class CardData {
  final String title;
  final DateTime date;

  CardData({required this.title, required this.date});
}

final List<CardData> sampleCards = [
  CardData(title: 'Header Text', date: DateTime(2024, 5, 4, 8, 0)),
  CardData(title: 'Header Text', date: DateTime(2024, 5, 5, 9, 30)),
  CardData(title: 'Header Text', date: DateTime(2024, 5, 6, 14, 15)),
];