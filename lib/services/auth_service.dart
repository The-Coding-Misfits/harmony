import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmony/utilites/login_register_states/login_state.dart';
import 'package:harmony/utilites/login_register_states/register_state.dart';

FirebaseAuth auth = FirebaseAuth.instance;


class AuthService {

  Future<REGISTER_STATE> registerUser(String email, String password) async{
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
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
}