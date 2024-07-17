import 'dart:developer';

import 'package:diet_diet_done/auth/login/view/create_new_pass_screen.dart';
import 'package:diet_diet_done/auth/login/view/otp_verification_screen.dart';
import 'package:diet_diet_done/auth/sign_up/view/otp_screen.dart';
import 'package:diet_diet_done/auth/sign_up/view/otp_succuss_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class SignUpUsingFirebaseController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signUpWithPhoneNumber(String phoneNumber) async {
    try {
      isLoading.value = true;

      final PhoneVerificationCompleted verifiedCallBack =
          (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
        log("Phone verification completed.");
        isLoading.value = false;
      };

      final PhoneVerificationFailed verificationFailedCallBack =
          (FirebaseAuthException e) {
        log("Phone verification failed: ${e.message}");
        isLoading.value = false;
        Get.snackbar("Phone number is not valid",
            "Please make sure that your phone number and country code is correct");
      };

      final PhoneCodeSent codeSentCallBack =
          (String verificationId, int? forceResendingToken) {
        Get.to(OtpScreen());
        isLoading.value = false;
      };

      firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verifiedCallBack,
        verificationFailed: verificationFailedCallBack,
        codeSent: codeSentCallBack,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: ${e.message}");
      isLoading.value = false;
      Get.snackbar("Firebase Auth Exception", e.message ?? "Unknown Error");
    } catch (e) {
      log("Error: $e");
      isLoading.value = false;
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  Future<void> verifyOtp({
    required String userOtp,
    required String verificationId,
  }) async {
    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        isLoading.value = false;
        Get.to(OTPSuccessScreen(screenName: false));
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      log("FirebaseAuthException: ${e.message}");
      Get.snackbar("Invalid OTP", "Recheck your OTP and try again");
    } catch (e) {
      isLoading.value = false;
      log("Error: $e");
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Future<User?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();

  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );

  //       final UserCredential authResult =
  //           await firebaseAuth.signInWithCredential(credential);

  //       return authResult.user;
  //     }
  //   } catch (error) {
  //     print("Google sign in error: $error");
  //     return null;
  //   }
  //   return null;
  // }

  Future<void> signOutFirebase() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      log("Error signing out: $e");
    }
  }

  Future<void> forgetPassword(String phoneNumber) async {
    try {
      isLoading.value = true;

      final PhoneVerificationCompleted verifiedCallBack =
          (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential);
        log("Phone verification completed.");
        isLoading.value = false;
      };

      final PhoneVerificationFailed verificationFailedCallBack =
          (FirebaseAuthException e) {
        log("Phone verification failed: ${e.message}");
        isLoading.value = false;
        Get.snackbar("Phone number is not valid",
            "Please make sure that your phone number and country code is correct");
      };

      final PhoneCodeSent codeSentCallBack =
          (String verificationId, int? forceResendingToken) {
        Get.to(ForgotPasswordOtpScreen(
          verificationId: verificationId,
        ));
        isLoading.value = false;
      };

      firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verifiedCallBack,
        verificationFailed: verificationFailedCallBack,
        codeSent: codeSentCallBack,
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: ${e.message}");
      isLoading.value = false;
      Get.snackbar("Firebase Auth Exception", e.message ?? "Unknown Error");
    } catch (e) {
      log("Error: $e");
      isLoading.value = false;
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  Future<void> forgetPasswordOtpVerification({
    required String userOtp,
    required String verificationId,
  }) async {
    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        isLoading.value = false;
        Get.to(CreateNewPassScreen());
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      log("FirebaseAuthException: ${e.message}");
      Get.snackbar("Invalid OTP", "Recheck your OTP and try again");
    } catch (e) {
      isLoading.value = false;
      log("Error: $e");
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
