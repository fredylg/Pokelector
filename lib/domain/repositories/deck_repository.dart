import '../entities/deck.dart';

abstract class DeckRepository {
  /// Get user's decks
  Future<List<Deck>> getUserDecks(String userId);

  /// Get specific deck
  Future<Deck?> getDeck(String deckId);

  /// Create new deck
  Future<Deck> createDeck(String userId, String name, {String format = 'standard'});

  /// Update deck
  Future<void> updateDeck(Deck deck);

  /// Delete deck
  Future<void> deleteDeck(String deckId);

  /// Add card to deck
  Future<void> addCardToDeck(String deckId, String cardId, int quantity);

  /// Update card quantity in deck
  Future<void> updateCardInDeck(String deckId, String cardId, int quantity);

  /// Remove card from deck
  Future<void> removeCardFromDeck(String deckId, String cardId);

  /// Reorder cards in deck
  Future<void> reorderDeckCards(String deckId, List<DeckCard> cards);

  /// Validate deck
  Future<DeckValidationResult> validateDeck(Deck deck);

  /// Export deck as text
  Future<String> exportDeckAsText(String deckId);

  /// Export deck as image
  Future<String> exportDeckAsImage(String deckId);

  /// Duplicate deck
  Future<Deck> duplicateDeck(String deckId, String newName);
}
