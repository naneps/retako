import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern_starter/app/common/utils.dart';
import 'package:getx_pattern_starter/app/models/user_model.dart';
import 'package:getx_pattern_starter/app/routes/app_pages.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController
  RxBool isShowPass = false.obs;
  RxBool isShowPassConfirm = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoggingIn = false.obs;
  RxString phone = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString passwordConfirm = ''.obs;
  RxString name = ''.obs;
  late FirebaseAuth auth;
  late FirebaseFirestore fireStore;
  final formKey = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  Rx<UserModel> user = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    auth = FirebaseAuth.instance;
    fireStore = FirebaseFirestore.instance;
  }

  @override
  void onClose() {}
  Future<void> registerWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: phone.value,
      verificationCompleted: (phoneAuthCredential) {
        auth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        // Get.toNamed(Routes.OTP, arguments: verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  // ValueNotifier<bool> isLoggingIn = ValueNotifier(false);
//
  void loginWithEmailAndPassword() async {
    if (isLoggingIn.value) {
      // Jika proses login sedang berlangsung, keluar dari fungsi
      return;
    }

    try {
      isLoggingIn.value = true;
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 1)); // Delay for one second

      await auth
          .signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      )
          .then((res) {
        if (res.user != null) {
          Get.offAllNamed(Routes.CORE);
        }
      });

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        Utils.errorMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Utils.errorMessage("Wrong password provided for that user.");
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    } finally {
      isLoggingIn.value = false;
    }
  }

  void registerWithEmailPassword() async {
    if (isLoading.value) {
      // Jika proses login sedang berlangsung, keluar dari fungsi
      return;
    }
    try {
      isLoading.value = true;
      isLoggingIn.value = true;
      await Future.delayed(const Duration(seconds: 1));
      Utils.loadingDialog();
      await auth
          .createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      )
          .then((res) async {
        if (res.user != null) {
          await res.user!.sendEmailVerification();
          await res.user!.updateDisplayName(name.value);
          bool userCreated = await createUser();
          if (userCreated) {
            Utils.successMessage("Register success");
            Get.offAllNamed(Routes.CORE);
          }
        }
      });
      isLoading.value = false;
      Utils.closeDialog();
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      isLoggingIn.value = false;
      if (e.code == 'weak-password') {
        Utils.errorMessage("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Utils.errorMessage("The account already exists for that email.");
      }
    } catch (e) {
      isLoggingIn.value = false;
      isLoading.value = false;
      print(e);
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuth =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  void signOut() async {
    await auth.signOut();
    // navigate to login page
    // listen to auth state
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        // Get.offAllNamed(Routes.ONBOARDING);
      } else {
        print('User is signed in!');
      }
    });
    // SystemNavigator.pop();
  }

  Future<bool> createUser() async {
    try {
      final usr = auth.currentUser;
      user.value = UserModel.fromJson(
        {
          "uid": usr!.uid,
          "name": name.value,
          "email": email.value,
          "avatar": null,
          "address": null,
        },
      );
      if (name.value.isEmpty || email.value.isEmpty || phone.value.isEmpty) {
        Utils.errorMessage("Please fill all required fields.");
        return false;
      }
      await fireStore.collection('users').doc(usr.uid).set(
            user.value.toJson(),
          );
      return true;
    } catch (e) {
      print(e);
      Utils.errorMessage("Failed to create user. Please try again.");
      return false;
    }
  }
}
