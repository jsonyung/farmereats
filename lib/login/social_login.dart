import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLogin {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

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

  // Facebook Sign-In
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        // Use accessToken to authenticate with your backend or Firebase
        print('Facebook Access Token: ${accessToken}');
      } else {
        print('Error signing in with Facebook: ${result.message}');
      }
    } catch (error) {
      print('Error signing in with Facebook: $error');
    }
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
