import 'package:mycustomers/core/models/user.dart';

abstract class AuthService {
  User get currentUser;

  void updateCurrentUser(User newUser);

  Future<void> signUpWithPhoneNumber(
    String phoneNumber,
    String password,
  );

  Future<void> signInWithPhoneNumber(
    String phoneNumber,
    String password,
  );

  Future<void> signInWithGoogle();

  Future<void> signUpWithGoogle();

  Future<void> signOut();

  Future<bool> get isUserLoggedIn;
}
