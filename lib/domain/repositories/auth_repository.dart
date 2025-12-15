import '../entities/user.dart' as entities;

abstract class AuthRepository {
  /// Get current user stream
  Stream<entities.AppUser?> get authStateChanges;

  /// Get current user
  entities.AppUser? get currentUser;

  /// Sign in with email and password
  Future<entities.AppUser> signInWithEmail(String email, String password);

  /// Sign up with email and password
  Future<entities.AppUser> signUpWithEmail(String email, String password);

  /// Sign in with Google
  Future<entities.AppUser> signInWithGoogle();

  /// Sign in with Apple
  Future<entities.AppUser> signInWithApple();

  /// Send password reset email
  Future<void> sendPasswordReset(String email);

  /// Sign out
  Future<void> signOut();

  /// Update user profile
  Future<void> updateProfile(entities.AppUser user);

  /// Delete account
  Future<void> deleteAccount();
}
