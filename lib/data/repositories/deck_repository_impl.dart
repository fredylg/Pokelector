import '../../domain/entities/deck.dart';
import '../../domain/repositories/deck_repository.dart';
import '../datasources/deck_remote_datasource.dart';

class DeckRepositoryImpl implements DeckRepository {
  final DeckRemoteDataSource remoteDataSource;

  DeckRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Deck>> getUserDecks(String userId) {
    return remoteDataSource.getUserDecks(userId);
  }

  @override
  Future<Deck?> getDeck(String deckId) {
    return remoteDataSource.getDeck(deckId);
  }

  @override
  Future<Deck> createDeck(String userId, String name, {String format = 'standard'}) {
    return remoteDataSource.createDeck(userId, name, format: format);
  }

  @override
  Future<void> updateDeck(Deck deck) {
    return remoteDataSource.updateDeck(deck);
  }

  @override
  Future<void> deleteDeck(String deckId) {
    return remoteDataSource.deleteDeck(deckId);
  }

  @override
  Future<void> addCardToDeck(String deckId, String cardId, int quantity) async {
    final deck = await getDeck(deckId);
    if (deck == null) throw Exception('Deck not found');

    final existingCardIndex = deck.cards.indexWhere((card) => card.cardId == cardId);
    final updatedCards = List<DeckCard>.from(deck.cards);

    if (existingCardIndex >= 0) {
      final existingCard = updatedCards[existingCardIndex];
      updatedCards[existingCardIndex] = existingCard.copyWith(
        quantity: existingCard.quantity + quantity,
      );
    } else {
      updatedCards.add(DeckCard(cardId: cardId, quantity: quantity));
    }

    final updatedDeck = deck.copyWith(cards: updatedCards, updatedAt: DateTime.now());
    await updateDeck(updatedDeck);
  }

  @override
  Future<void> updateCardInDeck(String deckId, String cardId, int quantity) async {
    final deck = await getDeck(deckId);
    if (deck == null) throw Exception('Deck not found');

    final updatedCards = List<DeckCard>.from(deck.cards);
    final cardIndex = updatedCards.indexWhere((card) => card.cardId == cardId);

    if (cardIndex >= 0) {
      if (quantity <= 0) {
        updatedCards.removeAt(cardIndex);
      } else {
        updatedCards[cardIndex] = updatedCards[cardIndex].copyWith(quantity: quantity);
      }
    }

    final updatedDeck = deck.copyWith(cards: updatedCards, updatedAt: DateTime.now());
    await updateDeck(updatedDeck);
  }

  @override
  Future<void> removeCardFromDeck(String deckId, String cardId) async {
    final deck = await getDeck(deckId);
    if (deck == null) throw Exception('Deck not found');

    final updatedCards = deck.cards.where((card) => card.cardId != cardId).toList();
    final updatedDeck = deck.copyWith(cards: updatedCards, updatedAt: DateTime.now());
    await updateDeck(updatedDeck);
  }

  @override
  Future<void> reorderDeckCards(String deckId, List<DeckCard> cards) async {
    final deck = await getDeck(deckId);
    if (deck == null) throw Exception('Deck not found');

    final updatedDeck = deck.copyWith(cards: cards, updatedAt: DateTime.now());
    await updateDeck(updatedDeck);
  }

  @override
  Future<DeckValidationResult> validateDeck(Deck deck) async {
    final errors = <String>[];
    final warnings = <String>[];

    // Check total cards (must be exactly 60)
    if (deck.totalCards != 60) {
      errors.add('Deck must contain exactly 60 cards (currently ${deck.totalCards})');
    }

    // Check 4x limit per card
    final cardCounts = <String, int>{};
    for (final card in deck.cards) {
      cardCounts[card.cardId] = (cardCounts[card.cardId] ?? 0) + card.quantity;
    }

    for (final entry in cardCounts.entries) {
      if (entry.value > 4) {
        errors.add('Cannot have more than 4 copies of the same card');
        break;
      }
    }

    // TODO: Add legality checks for the selected format
    // This would require checking each card against the format's banned/restricted list

    return DeckValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  @override
  Future<String> exportDeckAsText(String deckId) async {
    final deck = await getDeck(deckId);
    if (deck == null) throw Exception('Deck not found');

    // TODO: Implement proper text export with card names
    // This would require looking up card names from the card repository
    final buffer = StringBuffer();
    buffer.writeln('Deck: ${deck.name}');
    buffer.writeln('Format: ${deck.format}');
    buffer.writeln('');
    buffer.writeln('Cards:');

    for (final card in deck.cards) {
      buffer.writeln('${card.quantity}x ${card.cardId}'); // TODO: Use actual card names
    }

    return buffer.toString();
  }

  @override
  Future<String> exportDeckAsImage(String deckId) async {
    // TODO: Implement image export functionality
    // This would require generating an image representation of the deck
    throw UnimplementedError('Image export not yet implemented');
  }

  @override
  Future<Deck> duplicateDeck(String deckId, String newName) async {
    final originalDeck = await getDeck(deckId);
    if (originalDeck == null) throw Exception('Deck not found');

    return createDeck(originalDeck.userId, newName, format: originalDeck.format);
  }
}
