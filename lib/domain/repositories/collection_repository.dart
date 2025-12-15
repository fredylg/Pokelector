import '../entities/collection.dart';

abstract class CollectionRepository {
  /// Get user's collection
  Future<List<CollectionEntry>> getUserCollection(String userId);

  /// Add card to collection
  Future<void> addToCollection(String userId, String cardId, int quantity);

  /// Update card quantity in collection
  Future<void> updateCollectionQuantity(String userId, String cardId, int quantity);

  /// Remove card from collection
  Future<void> removeFromCollection(String userId, String cardId);

  /// Get collection entry for specific card
  Future<CollectionEntry?> getCollectionEntry(String userId, String cardId);

  /// Search collection by card name
  Future<List<CollectionEntry>> searchCollection(String userId, String query);

  /// Get collection filtered by set
  Future<List<CollectionEntry>> getCollectionBySet(String userId, String setId);

  /// Get collection filtered by type
  Future<List<CollectionEntry>> getCollectionByType(String userId, String type);

  /// Get collection filtered by rarity
  Future<List<CollectionEntry>> getCollectionByRarity(String userId, String rarity);

  /// Sync collection with remote
  Future<void> syncCollection(String userId);

  /// Get total cards in collection
  Future<int> getCollectionSize(String userId);
}
