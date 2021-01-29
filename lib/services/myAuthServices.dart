import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireworks/models/user.dart';

class MyAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Users _userCreater(FirebaseUser firebaseUser) {
    return firebaseUser == null ? null : Users.madeFromFirebase(firebaseUser);
  }

  Stream<Users> get statusFollower {
    return _firebaseAuth.onAuthStateChanged.map(_userCreater);
  }

  Future<Users> anonymLogin() async {
    var authResult = await _firebaseAuth.signInAnonymously();
    return _userCreater(authResult.user);
  }

  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }
}
