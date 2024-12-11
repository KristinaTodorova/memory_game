class CardModel {
  final String id; 
  final int number; 
  bool isFlipped; 
  bool isMatched;

  CardModel({
    required this.id,
    required this.number,
    this.isFlipped = false,
    this.isMatched = false,
  });

  void reset() {
    isFlipped = false;
    isMatched = false;
  }
}