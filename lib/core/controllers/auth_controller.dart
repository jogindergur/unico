import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unico/utils/instances.dart';
import 'package:unico/utils/shared_preference.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final TextEditingController emailController =
      TextEditingController(text: kDebugMode ? "test@unico.com" : "");
  final TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? "Unico@1223" : "");
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var isLoading = false.obs;
  var isGoogleLoading = false.obs;

  Future<bool> signInWithMail() async {
    isLoading.value = true;
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          return Future.error(
            FirebaseAuthException(
                message: "Connection Slow Try Again", code: "0"),
          );
        },
      );
      isLoading.value = false;
      String uid = firebaseAuth.currentUser?.uid ?? "";

      if (uid.isNotEmpty) {
        await prefs?.setString("UID", firebaseAuth.currentUser?.uid ?? "");
        // isLoading.value = false;
        return true;
      } else {
        // isLoading.value = false;
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        cartController.showMessage("No user found for that email.");
      } else if (e.code == "wrong-password") {
        cartController.showMessage("Incorrect password.");
      } else if (e.code == "invalid-credential") {
        cartController.showMessage("Invalid Credential.");
      }
      log("err uid: $e");
      isLoading.value = false;
      return false;
    } catch (e) {
      log("error: $e");
      isLoading.value = false;
      return false;
    }
  }

  signInWithGoogle() async {
    isGoogleLoading.value = true;

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      var details =
          await FirebaseAuth.instance.signInWithCredential(credential);
      log(details.toString());

      isGoogleLoading.value = false;
      String uid = firebaseAuth.currentUser?.uid ?? "";

      if (uid.isNotEmpty) {
        await prefs?.setString("UID", firebaseAuth.currentUser?.uid ?? "");
        // isLoading.value = false;
        return true;
      } else {
        // isLoading.value = false;
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        cartController.showMessage("No user found for that email.");
      } else if (e.code == "wrong-password") {
        cartController.showMessage("Incorrect password.");
      } else if (e.code == "invalid-credential") {
        cartController.showMessage("Invalid Credential.");
      }
      log("err uid: $e");
      isGoogleLoading.value = false;
      return false;
    } catch (e) {
      log("error: $e");
      isGoogleLoading.value = false;
      return false;
    }
  }

  logout() async {
    try {
      await firebaseAuth.signOut();
      await prefs?.clear();
      cartController.resetCart();
    } catch (e) {
      cartController.showMessage("Something went wrong");
    }
  }
}
