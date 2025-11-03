import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_discovery_app/core/errors/exceptions.dart';
import 'package:movie_discovery_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Register new user with email and password
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  });

  /// Sign in with Google
  Future<UserModel> signInWithGoogle();

  /// Sign out
  Future<void> signOut();

  /// Get current authenticated user
  Future<UserModel?> getCurrentUser();

  /// Check if user is authenticated
  Future<bool> isAuthenticated();

  /// Listen to auth state changes
  Stream<UserModel?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  final firebase_auth.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const ServerException('Sign in failed - no user returned');
      }

      return UserModel.fromFirebaseUser(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw ServerException(_getErrorMessage(e.code));
    } catch (e) {
      throw ServerException('Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const ServerException('Registration failed - no user returned');
      }

      // Update display name if provided
      if (displayName != null && displayName.isNotEmpty) {
        await credential.user!.updateDisplayName(displayName);
        await credential.user!.reload();
        final updatedUser = firebaseAuth.currentUser;
        if (updatedUser != null) {
          return UserModel.fromFirebaseUser(updatedUser);
        }
      }

      return UserModel.fromFirebaseUser(credential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw ServerException(_getErrorMessage(e.code));
    } catch (e) {
      throw ServerException('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw const ServerException('Google sign in aborted by user');
      }

      // Obtain the auth details from the request
      final googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw const ServerException('Google sign in failed - no user returned');
      }

      return UserModel.fromFirebaseUser(userCredential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw ServerException(_getErrorMessage(e.code));
    } catch (e) {
      throw ServerException('Google sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([
        firebaseAuth.signOut(),
        googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw ServerException('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    } catch (e) {
      throw ServerException('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return firebaseAuth.currentUser != null;
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return UserModel.fromFirebaseUser(user);
    });
  }

  /// Convert Firebase Auth error codes to user-friendly messages
  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'invalid-email':
        return 'The email address is not valid';
      case 'weak-password':
        return 'The password is too weak';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'too-many-requests':
        return 'Too many requests. Please try again later';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      default:
        return 'Authentication failed: $code';
    }
  }
}
