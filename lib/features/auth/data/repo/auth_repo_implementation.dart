import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_ai/features/auth/data/repo/auth_repo_declaration.dart';

class AuthRepoImplementation implements AuthRepoDeclaration {
  @override
  Future<void> userLogIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // credential.user!.emailVerified;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else {
        throw 'Authentication failed: ${e.message}';
      }
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  @override
  Future<void> userSignUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.signOut();
      // await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      } else {
        throw 'Authentication failed: ${e.message}';
      }
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  @override
  Future<void> resetPassowrd(String email) async {
    try {
      FirebaseAuth.instance.setLanguageCode("en");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found with that email.');
      } else if (e.code == 'invalid-email') {
        throw ('The email address is badly formatted.');
      } else {
        throw 'Reset password failed: ${e.message}';
      }
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }
}
