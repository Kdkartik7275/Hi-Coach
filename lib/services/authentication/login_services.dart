import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_coach/core/common/exceptions/firebase_auth_exceptions.dart';
import 'package:hi_coach/core/common/exceptions/firebase_exceptions.dart';

class LoginServices {
  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
