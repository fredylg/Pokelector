import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/collection.dart';

abstract class CollectionRemoteDataSource {
  Future<List<CollectionEntry>> getUserCollection(String userId);
  Future<void> addToCollection(String userId, String cardId, int quantity);
  Future<void> updateCollectionQuantity(String userId, String cardId, int quantity);
  Future<void> removeFromCollection(String userId, String cardId);
  Future<CollectionEntry?> getCollectionEntry(String userId, String cardId);
  Stream<List<CollectionEntry>> watchUserCollection(String userId);
}

class CollectionRemoteDataSourceImpl implements CollectionRemoteDataSource {
  final FirebaseFirestore firestore;

  CollectionRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<CollectionEntry>> getUserCollection(String userId) async {
    try {
      final querySnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('collection')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['userId'] = userId;
        data['cardId'] = doc.id;
        return CollectionEntry.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Failed to get user collection: $e');
    }
  }

  @override
  Future<void> addToCollection(String userId, String cardId, int quantity) async {
    try {
      final docRef = firestore
          .collection('users')
          .doc(userId)
          .collection('collection')
          .doc(cardId);

      final doc = await docRef.get();
      if (doc.exists) {
        // Update existing quantity
        final data = doc.data()!;
        data['userId'] = userId;
        data['cardId'] = cardId;
        final existingEntry = CollectionEntry.fromJson(data);
        await updateCollectionQuantity(userId, cardId, existingEntry.quantity + quantity);
      } else {
        // Create new entry
        final entry = CollectionEntry(
          userId: userId,
          cardId: cardId,
          quantity: quantity,
          updatedAt: DateTime.now(),
        );
        await docRef.set(entry.toJson());
      }
    } catch (e) {
      throw Exception('Failed to add to collection: $e');
    }
  }

  @override
  Future<void> updateCollectionQuantity(String userId, String cardId, int quantity) async {
    try {
      if (quantity <= 0) {
        await removeFromCollection(userId, cardId);
        return;
      }

      final entry = CollectionEntry(
        userId: userId,
        cardId: cardId,
        quantity: quantity,
        updatedAt: DateTime.now(),
      );

      await firestore
          .collection('users')
          .doc(userId)
          .collection('collection')
          .doc(cardId)
          .set(entry.toJson());
    } catch (e) {
      throw Exception('Failed to update collection quantity: $e');
    }
  }

  @override
  Future<void> removeFromCollection(String userId, String cardId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('collection')
          .doc(cardId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove from collection: $e');
    }
  }

  @override
  Future<CollectionEntry?> getCollectionEntry(String userId, String cardId) async {
    try {
      final doc = await firestore
          .collection('users')
          .doc(userId)
          .collection('collection')
          .doc(cardId)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        data['userId'] = userId;
        data['cardId'] = cardId;
        return CollectionEntry.fromJson(data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get collection entry: $e');
    }
  }

  @override
  Stream<List<CollectionEntry>> watchUserCollection(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('collection')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              data['userId'] = userId;
              data['cardId'] = doc.id;
              return CollectionEntry.fromJson(data);
            }).toList());
  }
}
