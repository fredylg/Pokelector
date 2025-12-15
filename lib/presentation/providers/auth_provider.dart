import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_remote_datasource.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  AppUser? _currentUser;
  bool _isLoading = false;

  AuthProvider()
      : _authRepository = AuthRepositoryImpl(
          AuthRemoteDataSourceImpl(
            firebaseAuth: auth.FirebaseAuth.instance,
            firestore: FirebaseFirestore.instance,
          ),
        ) {
    _initializeAuthState();
  }

  AppUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  Stream<AppUser?> get authStateChanges => _authRepository.authStateChanges;

  void _initializeAuthState() {
    _authRepository.authStateChanges.listen((user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  Future<void> signInWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      _currentUser = await _authRepository.signInWithEmail(email, password);
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      _currentUser = await _authRepository.signUpWithEmail(email, password);
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    _setLoading(true);
    try {
      // TODO: Implement Google Sign In
      throw Exception('Google Sign In not yet implemented');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithApple() async {
    _setLoading(true);
    try {
      _currentUser = await _authRepository.signInWithApple();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> sendPasswordReset(String email) async {
    _setLoading(true);
    try {
      await _authRepository.sendPasswordReset(email);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authRepository.signOut();
      _currentUser = null;
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateProfile(AppUser user) async {
    _setLoading(true);
    try {
      await _authRepository.updateProfile(user);
      _currentUser = user;
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteAccount() async {
    _setLoading(true);
    try {
      await _authRepository.deleteAccount();
      _currentUser = null;
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
