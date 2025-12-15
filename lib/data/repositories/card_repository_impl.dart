import '../../domain/entities/card.dart';
import '../../domain/repositories/card_repository.dart';
import '../datasources/card_remote_datasource.dart';

class CardRepositoryImpl implements CardRepository {
  final CardRemoteDataSource remoteDataSource;

  CardRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PokemonCard>> searchCards(String query, {int limit = 50}) {
    return remoteDataSource.searchCards(query, limit: limit);
  }

  @override
  Future<PokemonCard?> getCard(String cardId) {
    return remoteDataSource.getCard(cardId);
  }

  @override
  Future<List<PokemonCard>> getCardsBySet(String setId, {int limit = 100}) {
    return remoteDataSource.getCardsBySet(setId, limit: limit);
  }

  @override
  Future<List<PokemonCard>> getCardsByType(String type, {int limit = 100}) {
    return remoteDataSource.getCardsByType(type, limit: limit);
  }

  @override
  Future<List<PokemonCard>> getCardsByRarity(String rarity, {int limit = 100}) {
    return remoteDataSource.getCardsByRarity(rarity, limit: limit);
  }

  @override
  Future<List<PokemonCard>> getStandardLegalCards({int limit = 100}) {
    return remoteDataSource.getStandardLegalCards(limit: limit);
  }

  @override
  Future<List<PokemonCard>> getExpandedLegalCards({int limit = 100}) {
    return remoteDataSource.getExpandedLegalCards(limit: limit);
  }

  @override
  Future<void> syncCards() async {
    // TODO: Implement card synchronization logic
    // This would typically involve checking for updates from the API
    // and updating the Firestore database
  }

  @override
  Future<int> getLocalCardCount() async {
    // TODO: Implement local card count (would check SQLite database)
    // For now, return 0 as we don't have local caching implemented yet
    return 0;
  }

  @override
  Future<bool> isDatabaseUpToDate() async {
    try {
      final metadata = await remoteDataSource.getCardDatabaseMetadata();
      if (metadata == null) return false;

      // TODO: Compare local version with remote version
      // For now, assume it's up to date
      return true;
    } catch (e) {
      return false;
    }
  }
}
