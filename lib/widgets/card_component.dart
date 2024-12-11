import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:memory_game/game.dart';
import 'package:memory_game/models/card_model.dart';

class CardComponent extends PositionComponent with TapCallbacks {
  final CardModel card;
  final MemoryGame game;

  CardComponent(this.card, Vector2 position, Vector2 size, this.game)
      : super(position: position, size: size);

  @override
  void render(Canvas canvas) {
    const double margin = 5.0;
    final Rect innerRect = Rect.fromLTWH(
      margin, 
      margin,
      size.x - 2 * margin,
      size.y - 2 * margin,
    );

    final paint = Paint()
      ..color = card.isFlipped || card.isMatched ? Colors.white : Colors.blue;
    canvas.drawRect(innerRect, paint);

    if (card.isFlipped || card.isMatched) {
      const double fontSize = 22; 
      const textStyle = TextStyle(color: Colors.black, fontSize: fontSize);
      final textSpan = TextSpan(text: card.number.toString(), style: textStyle);

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      textPainter.paint(
        canvas,
        Offset(
          margin + (innerRect.width / 2 - textPainter.width / 2),
          margin + (innerRect.height / 2 - textPainter.height / 2),
        ),
      );
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!card.isFlipped && !card.isMatched) {
      game.flipCard(card);
    }
  }
}
