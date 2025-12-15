import '../entities/card.dart';

abstract class CardRepository {
  /// Search for cards by name
  Future<List<PokemonCard>> searchCards(String query, {int limit = 50});

  /// Get a specific card by ID
  Future<PokemonCard?> getCard(String cardId);

  /// Get cards by set
  Future<List<PokemonCard>> getCardsBySet(String setId, {int limit = 100});

  /// Get cards by type
  Future<List<PokemonCard>> getCardsByType(String type, {int limit = 100});

  /// Get cards by rarity
  Future<List<PokemonCard>> getCardsByRarity(String rarity, {int limit = 100});

  /// Get standard legal cards
  Future<List<PokemonCard>> getStandardLegalCards({int limit = 100});

  /// Get expanded legal cards
  Future<List<PokemonCard>> getExpandedLegalCards({int limit = 100});

  /// Sync cards from remote database
  Future<void> syncCards();

  /// Get local card count
  Future<int> getLocalCardCount();

  /// Check if local database is up to date
  Future<bool> isDatabaseUpToDate();
}
