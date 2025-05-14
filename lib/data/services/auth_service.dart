import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // JWT token for authentication
  Future<String?> getIdToken() async {
    final user = _firebaseAuth.currentUser;
    return await user?.getIdToken();
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch(e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // begin interactive sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // obtain auth details from request
      final GoogleSignInAuthentication? gAuth = await gUser?.authentication;

      //create  new credential for user
      final credential = GoogleAuthProvider.credential(accessToken: gAuth?.accessToken, idToken: gAuth?.idToken,);

      // sign in
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential;
    } on FirebaseAuthException catch(e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}