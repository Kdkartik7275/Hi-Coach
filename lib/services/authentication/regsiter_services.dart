import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_coach/core/common/exceptions/firebase_auth_exceptions.dart';
import 'package:hi_coach/core/common/exceptions/firebase_exceptions.dart';
import 'package:hi_coach/services/profile/profile_Services.dart';

class RegisterServices {
  final services = ProfileServices();

  Future<UserCredential> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
