import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/card.dart';

abstract class CardRemoteDataSource {
  Future<List<PokemonCard>> searchCards(String query, {int limit = 50});
  Future<PokemonCard?> getCard(String cardId);
  Future<List<PokemonCard>> getCardsBySet(String setId, {int limit = 100});
  Future<List<PokemonCard>> getCardsByType(String type, {int limit = 100});
  Future<List<PokemonCard>> getCardsByRarity(String rarity, {int limit = 100});
  Future<List<PokemonCard>> getStandardLegalCards({int limit = 100});
  Future<List<PokemonCard>> getExpandedLegalCards({int limit = 100});
  Future<Map<String, dynamic>?> getCardDatabaseMetadata();
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final FirebaseFirestore firestore;

  CardRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<PokemonCard>> searchCards(String query, {int limit = 50}) async {
    try {
      // Search by name (case-insensitive prefix search)
      final querySnapshot = await firestore
          .collection('cards')
          .where('nameLower', isGreaterThanOrEqualTo: query.toLowerCase())
          .where('nameLower', isLessThan: '${query.toLowerCase()}\uf8ff')
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => PokemonCard.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search cards: $e');
    }
  }

  @override
  Future<PokemonCard?> getCard(String cardId) async {
    try {
      final docSnapshot = await firestore.collection('cards').doc(cardId).get();
      if (docSnapshot.exists) {
        return PokemonCard.fromJson(docSnapshot.data()!);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get card: $e');
    }
  }

  @override
  Future<List<PokemonCard>> getCardsBySet(String setId, {int limit = 100}) async {
    try {
      final querySnapshot = await firestore
          .collection('cards')
          .where('set.id', isEqualTo: setId)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => PokemonCard.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get cards by set: $e');
    }
  }

  @override
  Future<List<PokemonCard>> getCardsByType(String type, {int limit = 100}) async {
    try {
      final querySnapshot = await firestore
          .collection('cards')
          .where('types', arrayContains: type)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => PokemonCard.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get cards by type: $e');
    }
  }

  @override
  Future<List<PokemonCard>> getCardsByRarity(String rarity, {int limit = 100}) async {
    try {
      final querySnapshot = await firestore
          .collection('cards')
          .where('rarity', isEqualTo: rarity)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => PokemonCard.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get cards by rarity: $e');
    }
  }

  @override
  Future<List<PokemonCard>> getStandardLegalCards({int limit = 100}) async {
    try {
      final querySnapshot = await firestore
          .collection('cards')
          .where('legalities.standard', isEqualTo: 'Legal')
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => PokemonCard.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get standard legal cards: $e');
    }
  }

  @override
  Future<List<PokemonCard>> getExpandedLegalCards({int limit = 100}) async {
    try {
      final querySnapshot = await firestore
          .collection('cards')
          .where('legalities.expanded', isEqualTo: 'Legal')
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => PokemonCard.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get expanded legal cards: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getCardDatabaseMetadata() async {
    try {
      final docSnapshot = await firestore.collection('meta').doc('card_db').get();
      return docSnapshot.exists ? docSnapshot.data() : null;
    } catch (e) {
      throw Exception('Failed to get card database metadata: $e');
    }
  }
}
