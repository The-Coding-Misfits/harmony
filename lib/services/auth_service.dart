import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/firestore.dart';
import 'package:harmony/utilites/login_register_states/delete_state.dart';
import 'package:harmony/utilites/login_register_states/login_state.dart';
import 'package:harmony/utilites/login_register_states/signout_state.dart';
import 'package:harmony/utilites/login_register_states/register_state.dart';

FirebaseAuth auth = FirebaseAuth.instance;


class AuthService {

  static HarmonyUser? currHarmonyUser;
  static UserCredential? userCredentials;

  Future<HarmonyUser?> initCurrUser(String uid) async{
    currHarmonyUser = await FireStoreService().getUserFromUID(uid);
    return currHarmonyUser;
  }

  static void createHarmonyUser(User newUser, String username) async{
    currHarmonyUser = await FireStoreService().createUser(newUser.uid, username);
  }


  Future<REGISTER_STATE> registerUser(String email, String username, String password) async{
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredentials = userCredential;
      createHarmonyUser(userCredential.user!, username);
      return REGISTER_STATE.SUCCESSFUL;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return REGISTER_STATE.WEAK_PASSWORD;
      } else if (e.code == 'email-already-in-use') {
        return REGISTER_STATE.EMAIL_ALREADY_IN_USE;
      }
    }
    return REGISTER_STATE.UNKNOWN_ERROR;
  }

  Future<LOGIN_STATE> logUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      userCredentials = userCredential;
      initCurrUser(userCredential.user!.uid);
      return LOGIN_STATE.SUCCESSFUL;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return LOGIN_STATE.USER_NOT_FOUND;
      } else if (e.code == 'wrong-password') {
        return LOGIN_STATE.WRONG_PASSWORD;
      }
    }
    return LOGIN_STATE.UNKNOWN;
  }

  Future<SIGNOUT_STATE> signOutUser() async {
    try {
      await auth.signOut();
      currHarmonyUser = null;
      return SIGNOUT_STATE.SUCCESSFUL;
    } on FirebaseAuthException {
      return SIGNOUT_STATE.ERROR;
    }
  }

  Future deleteAccount() async {
    try {
      await auth.currentUser!.reauthenticateWithCredential(userCredentials!.credential!);
      await auth.currentUser!.delete();

      return DELETE_STATE.SUCCESSFUL;
    } on FirebaseAuthException {
      return DELETE_STATE.ERROR;
    }
  }
}