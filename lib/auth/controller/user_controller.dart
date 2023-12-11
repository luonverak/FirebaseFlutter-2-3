import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase/auth/model/user_model.dart';
import 'package:flutter_firebase/auth/view/login_screen.dart';
import 'package:flutter_firebase/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController extends GetxController {
  Future<void> createUser(UserModel model) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: model.email,
            password: model.password,
          )
          .whenComplete(
              () => Get.snackbar('Success', 'Account has been create'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    update();
  }

  Future<void> loginAccount(UserModel model) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      if (credential.user != null) {
        Get.offAll(HomeScreen());
        Get.snackbar('Success', 'Account has been login.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else {
        Get.snackbar('Error', 'Login error.');
      }
    }
    update();
  }

  Future onCheckUser() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.offAll(LoginScreen());
        } else {
          Get.offAll(HomeScreen());
        }
      });
    });
    update();
  }

  Future logOutUser() async {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => FirebaseAuth.instance.signOut());
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
