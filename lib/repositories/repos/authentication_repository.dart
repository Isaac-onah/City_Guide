import 'package:cityguide/repositories/repos/user_repository.dart';
import 'package:cityguide/screens/auth/LoginScreen.dart';
import 'package:cityguide/screens/auth/verify_email.dart';
import 'package:cityguide/screens/mainscreens/start_tour.dart';
import 'package:cityguide/screens/mainscreens/welcome.dart';
import 'package:cityguide/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:cityguide/utils/exceptions/firebase_exceptions.dart';
import 'package:cityguide/utils/exceptions/format_exceptions.dart';
import 'package:cityguide/utils/exceptions/platform_exceptions.dart';
import 'package:cityguide/utils/popups/full_screen_loader.dart';
import 'package:cityguide/utils/storage/storage_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///variable
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  ///Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  ///called from main.dart on applaunch
  @override
  void onReady() {
    //remove the native splash screen
    FlutterNativeSplash.remove();
    //Redirect to the appropriate screen
    screenRedirect();
  }

  //Function to determine the relevant screen and redirect accordingly
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      //if the user is logged in
      if (user.emailVerified) {
        //if the user's email is verified, navigate to the main navigation menu
        // Get the current user's UID
        String currentUserUid = _auth.currentUser!.uid;

        // Reference to the user document in the 'users' collection
        DocumentReference userRef =
        FirebaseFirestore.instance.collection('Users').doc(currentUserUid);

        // Check if the user document exists
        DocumentSnapshot userSnapshot = await userRef.get();

        if (userSnapshot.exists) {
          //initialize user specific Storage
          await TLocalStorage.init(user.uid);

          // User document exists, proceed with login, navigate to the main navigation menu
          var result = Get.offAll(() => StartTourScreen());
          if (result != null) {
            result.then((value) => TFullScreenLoader.stopLoading());
          }
        } else {
          Get.offAll(() => const LoginScreen());
          //remove loader
          TFullScreenLoader.stopLoading();
        }
      } else {
        //if the user's email is not verified, navigate to the VerificationEmail screen
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
       Get.offAll(() => const LoginScreen());

    }
  }

  /* ------------------------------ Email and Password sign in ---------------------------------------*/

  /// [EmailAuthentication] - Sign In
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - REGISTRATION
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailVerification] - RE AUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      //Create Credentials
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // Reauthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /* ---------------------------------------- ./end Federated identity & social sign in ------------------------------------ */
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// DELETE USER - Remove user Auth and Firestore Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removerUserData(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
