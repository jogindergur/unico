import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unico/utils/instances.dart';
import 'package:unico/utils/shared_preference.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final TextEditingController emailController = TextEditingController(text: kDebugMode ? "test@unico.com" : "");
  final TextEditingController passwordController = TextEditingController(text: kDebugMode ? "Unico@1223" : "");
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var isLoading = false.obs;

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
      if (e.code == 'user-not-found') {
        cartController.showMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        cartController.showMessage("Incorrect password.");
      }
      return false;
    } catch (e) {
      log(e.toString());

      return false;
    }
  }

  logout() async {
    try {
      await firebaseAuth.signOut();
      await prefs?.clear();
    } catch (e) {
      cartController.showMessage("Something went wrong");
    }
  }
}
