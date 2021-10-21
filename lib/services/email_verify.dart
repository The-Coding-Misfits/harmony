import 'package:firebase_auth/firebase_auth.dart';
///REQUIRES A DEEPLINK
/// WE DONT NEED DEEP LINKS RIGHT NOW BC THEY REQUIRE SHA
/// HOWEVER DEEP LINKS CAN BE IMPLEMENTED TOWARDS THE END OF THE PROJECT FOR LEARNING NSTUFF

class EmailVerifier {


  void verifyEmail(User user){
    if (!user.emailVerified){
      ActionCodeSettings actionCodeSettings = new ActionCodeSettings(
          url: ''

      );
    }
  }

}