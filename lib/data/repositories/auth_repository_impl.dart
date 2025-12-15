import '../../domain/entities/user.dart' as entities;
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Stream<entities.AppUser?> get authStateChanges => remoteDataSource.authStateChanges;

  @override
  entities.AppUser? get currentUser => remoteDataSource.currentUser;

  @override
  Future<entities.AppUser> signInWithEmail(String email, String password) {
    return remoteDataSource.signInWithEmail(email, password);
  }

  @override
  Future<entities.AppUser> signUpWithEmail(String email, String password) {
    return remoteDataSource.signUpWithEmail(email, password);
  }

  @override
  Future<entities.AppUser> signInWithGoogle() {
    return remoteDataSource.signInWithGoogle();
  }

  @override
  Future<entities.AppUser> signInWithApple() {
    return remoteDataSource.signInWithApple();
  }

  @override
  Future<void> sendPasswordReset(String email) {
    return remoteDataSource.sendPasswordReset(email);
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }

  @override
  Future<void> updateProfile(entities.AppUser user) {
    return remoteDataSource.updateProfile(user);
  }

  @override
  Future<void> deleteAccount() {
    return remoteDataSource.deleteAccount();
  }
}
