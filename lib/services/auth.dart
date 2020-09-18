import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterLogin/enums/auth_result_status.dart';
import 'package:flutterLogin/error/error_handling.dart';
import 'package:flutterLogin/models/userModel.dart';
import 'package:flutterLogin/services/firestore.dart';

class AuthServices {
  final firestoreServices = FirestoreServices();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthResultStatus _status;

  //mapping the firebase user to our user-model
  UserModel _userFromFirebase(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        .map(_userFromFirebase); //firebase user nai pass garcha
  }

  //sign in with email and password
  Future<AuthResultStatus> signInUser(String email, String password) async {
    // String errorMessage = "";
    // User user;
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // user = result.user;

      if (result.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }

      //return _userFromFirebase(user);

    } catch (e) {
      // print(e.toString());
      // return null;
      print('Exception @login: $e');
      //print(e.code);
      _status = AuthExceptionHandler.handleException(e);
      //print(_status);
    }
    return _status;
  }
  //sign up with email and password

  Future registerData(String email, String password, String name,
      String address, String dob) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        _status = AuthResultStatus.successful;
        firestoreServices.saveUserData(
            name, email, password, dob, address, result.user.uid);
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
      // print(e.toString());
      // return null;
    }
    return _status;
  }
  // Future<dynamic> registerData(String email, String password, String name,
  //     String address, String dob) async {
  //   String errorMessage;
  //   User user;

  //   await _auth
  //       .createUserWithEmailAndPassword(email: email, password: password)
  //       .then((u) {
  //     //storing the user in the firestore
  //     UserCredential result = u;
  //     user = result.user;
  //     print(u);
  //     firestoreServices.saveUserData(
  //         name, email, password, dob, address, user.uid);
  //   }).catchError((e) {
  //     switch (e.code) {
  //       case "ERROR_INVALID_EMAIL":
  //         errorMessage = "Your email address appears to be malformed.";
  //         break;
  //       case "ERROR_WRONG_PASSWORD":
  //         errorMessage = "Your password is wrong.";
  //         break;
  //       case "ERROR_USER_NOT_FOUND":
  //         errorMessage = "User with this email doesn't exist.";
  //         break;
  //       case "ERROR_USER_DISABLED":
  //         errorMessage = "User with this email has been disabled.";
  //         break;
  //       case "ERROR_TOO_MANY_REQUESTS":
  //         errorMessage = "Too many requests. Try again later.";
  //         break;
  //       case "ERROR_OPERATION_NOT_ALLOWED":
  //         errorMessage = "Signing in with Email and Password is not enabled.";
  //         break;
  //       default:
  //         errorMessage = "An undefined Error happened.";
  //     }
  //   });

  //   if (errorMessage != null) {
  //     return Future.error(errorMessage);
  //   } else {
  //     //return _userFromFirebase(user);
  //     return _userFromFirebase(user);
  //   }
  // }

  // print(e.toString());
  // return null;

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
