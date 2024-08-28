import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLogin {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Google Sign-In
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        // Use googleAuth to authenticate with your backend or Firebase
        print('Google User: ${googleUser.displayName}, Token: ${googleAuth.accessToken}');
        return true; // Successfully signed in
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
    return false; // Failed to sign in
  }


  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Attempt to log in with Facebook
      final LoginResult result = await FacebookAuth.instance.login();

      // Check the result status
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        // Create a credential for Firebase Auth
        final AuthCredential credential =
        FacebookAuthProvider.credential(accessToken.tokenString);

        // Sign in with the credential
        return await _auth.signInWithCredential(credential);
      } else {
        // Handle login errors or cancellations
        print('Error signing in with Facebook: ${result.message}');
      }
    } catch (error) {
      // Print or log any unexpected errors
      print('Error during Facebook sign-in: $error');
    }
    return null;
  }

/*  // Apple Sign-In
  Future<void> signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID credential = await SignInWithApple.getAppleIDCredential(scopes: []
       // scopes: [Scope.\\email, Scope.fullName],
      );
      // Use credential to authenticate with your backend or Firebase
      print('Apple ID Credential: ${credential.userIdentifier}');
    } catch (error) {
      print('Error signing in with Apple: $error');
    }
  }*/
}
