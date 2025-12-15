import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

import '../../domain/entities/scan.dart';

abstract class ScanRemoteDataSource {
  Future<bool> hasScanCredits(String userId);
  Future<int> getScanCreditBalance(String userId);
  Future<bool> deductScanCredit(String userId, String scanId);
  Future<String> uploadScanImage(String userId, String imagePath);
  Future<XimilarRecognitionResult> recognizeCard(String imageUrl);
}

class ScanRemoteDataSourceImpl implements ScanRemoteDataSource {
  final FirebaseFirestore firestore;
  final firebase_storage.FirebaseStorage storage;

  // TODO: Replace with actual Ximilar API key and endpoint
  static const String _ximilarApiKey = 'REPLACE_WITH_XIMILAR_API_KEY';
  static const String _ximilarEndpoint = 'https://api.ximilar.com/recognition/v2/pokemon';

  ScanRemoteDataSourceImpl({
    required this.firestore,
    required this.storage,
  });

  @override
  Future<bool> hasScanCredits(String userId) async {
    try {
      final balance = await getScanCreditBalance(userId);
      return balance > 0;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> getScanCreditBalance(String userId) async {
    try {
      final userDoc = await firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data()!;
        final scanCredits = userData['scanCredits'] as Map<String, dynamic>?;
        return scanCredits?['balance'] ?? 0;
      }
      return 0;
    } catch (e) {
      throw Exception('Failed to get scan credit balance: $e');
    }
  }

  @override
  Future<bool> deductScanCredit(String userId, String scanId) async {
    try {
      // Use a transaction to ensure atomic update
      return await firestore.runTransaction((transaction) async {
        final userRef = firestore.collection('users').doc(userId);
        final userDoc = await transaction.get(userRef);

        if (!userDoc.exists) return false;

        final userData = userDoc.data()!;
        final scanCredits = userData['scanCredits'] as Map<String, dynamic>? ?? {};
        final currentBalance = scanCredits['balance'] ?? 0;

        if (currentBalance <= 0) return false;

        // Deduct credit
        final updatedCredits = Map<String, dynamic>.from(scanCredits);
        updatedCredits['balance'] = currentBalance - 1;

        transaction.update(userRef, {'scanCredits': updatedCredits});

        // Log the scan event
        final scanEventRef = firestore
            .collection('users')
            .doc(userId)
            .collection('scan_events')
            .doc(scanId);

        transaction.set(scanEventRef, {
          'scanId': scanId,
          'userId': userId,
          'status': 'success',
          'timestamp': FieldValue.serverTimestamp(),
        });

        return true;
      });
    } catch (e) {
      throw Exception('Failed to deduct scan credit: $e');
    }
  }

  @override
  Future<String> uploadScanImage(String userId, String imagePath) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef = storage.ref().child('scans/$userId/$fileName');

      // Upload file
      await storageRef.putFile(
        File(imagePath),
        firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {
            'uploadedAt': DateTime.now().toIso8601String(),
            'userId': userId,
          },
        ),
      );

      // Get download URL
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload scan image: $e');
    }
  }

  @override
  Future<XimilarRecognitionResult> recognizeCard(String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse(_ximilarEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $_ximilarApiKey',
        },
        body: jsonEncode({
          'records': [
            {
              'url': imageUrl,
              '_url': imageUrl,
            }
          ],
          'task_id': 'pokemon-recognition',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final records = data['records'] as List<dynamic>;

        if (records.isNotEmpty) {
          final record = records.first;
          final bestMatch = record['best_label'] as Map<String, dynamic>;

          return XimilarRecognitionResult(
            predictedCardId: bestMatch['name'] ?? '',
            confidence: (bestMatch['prob'] ?? 0.0).toDouble(),
            metadata: record,
          );
        }
      }

      throw Exception('Failed to recognize card from image');
    } catch (e) {
      throw Exception('Card recognition failed: $e');
    }
  }
}
