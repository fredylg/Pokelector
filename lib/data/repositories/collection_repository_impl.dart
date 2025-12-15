import '../../domain/entities/collection.dart';
import '../../domain/repositories/collection_repository.dart';
import '../datasources/collection_remote_datasource.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionRemoteDataSource remoteDataSource;

  CollectionRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CollectionEntry>> getUserCollection(String userId) {
    return remoteDataSource.getUserCollection(userId);
  }

  @override
  Future<void> addToCollection(String userId, String cardId, int quantity) {
    return remoteDataSource.addToCollection(userId, cardId, quantity);
  }

  @override
  Future<void> updateCollectionQuantity(String userId, String cardId, int quantity) {
    return remoteDataSource.updateCollectionQuantity(userId, cardId, quantity);
  }

  @override
  Future<void> removeFromCollection(String userId, String cardId) {
    return remoteDataSource.removeFromCollection(userId, cardId);
  }

  @override
  Future<CollectionEntry?> getCollectionEntry(String userId, String cardId) {
    return remoteDataSource.getCollectionEntry(userId, cardId);
  }

  @override
  Future<List<CollectionEntry>> searchCollection(String userId, String query) async {
    // TODO: Implement search in local cache first, then fallback to remote
    final collection = await getUserCollection(userId);
    return collection.where((entry) =>
        entry.cardId.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Future<List<CollectionEntry>> getCollectionBySet(String userId, String setId) async {
    final collection = await getUserCollection(userId);
    return collection.where((entry) => entry.setId == setId).toList();
  }

  @override
  Future<List<CollectionEntry>> getCollectionByType(String userId, String type) async {
    final collection = await getUserCollection(userId);
    return collection.where((entry) => entry.type == type).toList();
  }

  @override
  Future<List<CollectionEntry>> getCollectionByRarity(String userId, String rarity) async {
    final collection = await getUserCollection(userId);
    return collection.where((entry) => entry.rarity == rarity).toList();
  }

  @override
  Future<void> syncCollection(String userId) async {
    // TODO: Implement synchronization logic
    // This would sync local changes with remote and vice versa
  }

  @override
  Future<int> getCollectionSize(String userId) async {
    final collection = await getUserCollection(userId);
    return collection.fold<int>(0, (sum, entry) => sum + entry.quantity);
  }
}
