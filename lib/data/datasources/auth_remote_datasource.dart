import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart' as entities;

abstract class AuthRemoteDataSource {
  Stream<entities.AppUser?> get authStateChanges;
  entities.AppUser? get currentUser;
  Future<entities.AppUser> signInWithEmail(String email, String password);
  Future<entities.AppUser> signUpWithEmail(String email, String password);
  Future<entities.AppUser> signInWithGoogle();
  Future<entities.AppUser> signInWithApple();
  Future<void> sendPasswordReset(String email);
  Future<void> signOut();
  Future<void> updateProfile(entities.AppUser user);
  Future<void> deleteAccount();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Stream<entities.AppUser?> get authStateChanges =>
      firebaseAuth.authStateChanges().map(_firebaseUserToUser);

  @override
  entities.AppUser? get currentUser => _firebaseUserToUser(firebaseAuth.currentUser);

  @override
  Future<entities.AppUser> signInWithEmail(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = result.user!;
      if (firebaseUser != null) {
        await _ensureUserProfile(firebaseUser);
        return await _getUserProfile(firebaseUser.uid);
      }

      throw Exception('Sign in failed');
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<entities.AppUser> signUpWithEmail(String email, String password) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = result.user!;
      if (firebaseUser != null) {
        await _createUserProfile(firebaseUser);
        return await _getUserProfile(firebaseUser.uid);
      }

      throw Exception('Sign up failed');
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  @override
  Future<entities.AppUser> signInWithGoogle() async {
    throw UnimplementedError('Google Sign In not yet implemented');
  }

  @override
  Future<entities.AppUser> signInWithApple() async {
    throw UnimplementedError('Apple Sign In not yet implemented');
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send password reset: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  @override
  Future<void> updateProfile(entities.AppUser user) async {
    try {
      await firestore.collection('users').doc(user.id).update(user.toJson());
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        // Delete user data from Firestore
        await firestore.collection('users').doc(user.uid).delete();

        // Delete Firebase Auth user
        await user.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  Future<void> _createUserProfile(auth.User firebaseUser) async {
    final user = entities.AppUser(
      id: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      email: firebaseUser.email,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
      scanCredits: entities.ScanCredits(balance: 10, plan: 'free'),
      consents: {
        'analytics': false,
        'aiScan': false,
        'pricingLookup': false,
      },
    );

    await firestore.collection('users').doc(firebaseUser.uid).set(user.toJson());
  }

  Future<void> _ensureUserProfile(auth.User firebaseUser) async {
    final docRef = firestore.collection('users').doc(firebaseUser.uid);
    final doc = await docRef.get();

    if (!doc.exists) {
      await _createUserProfile(firebaseUser);
    } else {
      // Update last login
      await docRef.update({
        'lastLoginAt': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<entities.AppUser> _getUserProfile(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return entities.AppUser.fromJson(doc.data()!..['id'] = uid);
    }
    throw Exception('User profile not found');
  }

  entities.AppUser? _firebaseUserToUser(auth.User? firebaseUser) {
    if (firebaseUser == null) return null;

    return entities.AppUser(
      id: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      email: firebaseUser.email,
      createdAt: DateTime.now(),
      lastLoginAt: DateTime.now(),
    );
  }
}
