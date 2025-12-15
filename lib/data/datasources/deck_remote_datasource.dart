import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/deck.dart';

abstract class DeckRemoteDataSource {
  Future<List<Deck>> getUserDecks(String userId);
  Future<Deck?> getDeck(String deckId);
  Future<Deck> createDeck(String userId, String name, {String format = 'standard'});
  Future<void> updateDeck(Deck deck);
  Future<void> deleteDeck(String deckId);
  Stream<List<Deck>> watchUserDecks(String userId);
}

class DeckRemoteDataSourceImpl implements DeckRemoteDataSource {
  final FirebaseFirestore firestore;

  DeckRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<Deck>> getUserDecks(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('decks')
          .orderBy('updatedAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        data['userId'] = userId;
        return Deck.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get user decks: $e');
    }
  }

  @override
  Future<Deck?> getDeck(String deckId) async {
    try {
      // We need to find the deck by searching through user collections
      // This is a limitation of Firestore subcollections
      // In a production app, you might want to maintain a separate decks collection

      final usersSnapshot = await firestore.collection('users').get();
      for (final userDoc in usersSnapshot.docs) {
        final deckDoc = await userDoc.reference.collection('decks').doc(deckId).get();
        if (deckDoc.exists) {
          final data = deckDoc.data()!;
          data['id'] = deckDoc.id;
          data['userId'] = userDoc.id;
          return Deck.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get deck: $e');
    }
  }

  @override
  Future<Deck> createDeck(String userId, String name, {String format = 'standard'}) async {
    try {
      final deck = Deck(
        id: '', // Will be set by Firestore
        userId: userId,
        name: name,
        cards: [],
        format: format,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final docRef = await firestore
          .collection('users')
          .doc(userId)
          .collection('decks')
          .add(deck.toJson());

      return deck.copyWith(id: docRef.id);
    } catch (e) {
      throw Exception('Failed to create deck: $e');
    }
  }

  @override
  Future<void> updateDeck(Deck deck) async {
    try {
      final updateData = deck.toJson();
      updateData['updatedAt'] = DateTime.now().toIso8601String();

      await firestore
          .collection('users')
          .doc(deck.userId)
          .collection('decks')
          .doc(deck.id)
          .update(updateData);
    } catch (e) {
      throw Exception('Failed to update deck: $e');
    }
  }

  @override
  Future<void> deleteDeck(String deckId) async {
    try {
      // Find and delete the deck from the correct user collection
      final usersSnapshot = await firestore.collection('users').get();
      for (final userDoc in usersSnapshot.docs) {
        final deckRef = userDoc.reference.collection('decks').doc(deckId);
        final deckDoc = await deckRef.get();
        if (deckDoc.exists) {
          await deckRef.delete();
          return;
        }
      }
      throw Exception('Deck not found');
    } catch (e) {
      throw Exception('Failed to delete deck: $e');
    }
  }

  @override
  Stream<List<Deck>> watchUserDecks(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('decks')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['id'] = doc.id;
              data['userId'] = userId;
              return Deck.fromJson(data);
            }).toList());
  }
}
