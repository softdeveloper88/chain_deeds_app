import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/show_error_dialog.dart';
import 'package:chain_deeds_app/screens/authenatication_screens/bloc/auth_bloc.dart';
import 'package:chain_deeds_app/screens/main_screen/main_screen.dart';
import 'package:chain_deeds_app/screens/phone_screen/phone_screen.dart';
import 'package:chain_deeds_app/screens/phone_screen/verification_code_screen.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'auth_bottom_sheet_dialog.dart';
import 'bloc/auth_event.dart';
import 'bloc/auth_state.dart';


class WelcomeScreen extends StatefulWidget {

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  void initializeAsync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? deviceToken = prefs.getString('device_token');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? phone = prefs.getString('phone') ?? '';
    int? loginUserId = prefs.getInt('userId') ?? 0;
    String? accessToken = prefs.getString('access_token') ?? '';
      Constants.userToken = accessToken;
      Constants.logInUserId = loginUserId.toString();
      Constants.name = name ?? '';
      Constants.phone = phone ?? '';
      Constants.deviceToken = deviceToken ?? '';
      Constants.email = email ?? '';
      setState(() {});
      if(Constants.userToken !='' ){
       Future.delayed(Duration(milliseconds: 2000),(){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
       });
      }
    }
  AuthBloc authBloc=AuthBloc();
    @override
  void initState() {

      initializeAsync();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
      if (state is AuthFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error)),
        );
      } else if (state is AuthSuccess) {
        if (state.response['status']) {

          if(state.screen=="social_login") {
            if (state.response['data']['user']['phone_verified_at'] ==
                null) {

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>
                      PhoneScreen()));
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>
                  const MainScreen()));
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign up successful!')),
            );
          }else{
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>
                    VerificationCodeScreen(
                        isFrom:  'login',
                        onSubmit: (verified)
                    {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const MainScreen()));
                    })));
          }
        } else {
          showErrorDialog(state.response['errors'],context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign up failed!')),
          );
        }
      }
    },
    child:Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg_img.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Text(
                  "Chain of Deeds",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .07,
                      color: Colors.white,
                      wordSpacing: -3,
                      fontFamily: 'TypoGraphica'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: Image.asset(
                  "assets/logo.png",
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Text(
                  "Join the Movement Changing the World",
                  style: TextStyle(
                      color: Colors.white,
                      wordSpacing: -3,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: 'TypoGraphica'),
                ),
              ),
           if(Constants.userToken=='')  Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    AuthBottomSheetDialog().show(context,
                        text0: 'Sign in',
                        text1: 'Continue with Apple',
                        text2: 'Continue with Google',
                        text3: 'Sign Up with your e-mail',
                      onTapGoogleLogin:(){
                        onPressedGoogleLogin();
                      },
                      onTapAppleLogin:(){
                        signInWithApple();
                      },
                    );

                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: const Color(0xFFFFD319),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        color: Colors.black,
                        fontFamily: 'BG Flame Bold',
                      ),
                    )),
                  ),
                ),
              ),
              if(Constants.userToken=='')      Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: MaterialButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side:const BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    AuthBottomSheetDialog().show(
                        context,
                        text0: 'Log in with',
                        text1: 'Continue with Apple',
                        text2: 'Continue with Google',
                        text3: 'Log in with your e-mail',
                        onTapGoogleLogin:(){
                          onPressedGoogleLogin();
                        },
                        onTapAppleLogin:(){
                          signInWithApple();
                        },
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.033,
                            color: Colors.white,
                            fontFamily: 'BG Flame Bold'),

                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
  onPressedGoogleLogin() async {
    try {
      // GoogleSignIn().signOut();
      String? token = "";
      if (Platform.isAndroid) {
        await FirebaseMessaging.instance.getToken().then((token) async {
          debugPrint(token);
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          print(googleUser.toString());

          GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;
          String accessToken = googleSignInAuthentication.accessToken!;
          // await FirebaseMessaging.instance.getToken().then((token) async {
          //   print('token$googleUser');
          authBloc.add(SocialLoginSubmitted(
            googleUser.email,
            googleUser.displayName??"",
            // isSocialLogin: true,
            'google',
            // token: response.user!.uid ?? '',
            // deviceToken: token ?? '',
          ));
          GoogleSignIn().disconnect();
        });
      } else {
        await FirebaseMessaging.instance.getAPNSToken().then((token) async {
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          print(googleUser.toString());

          GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser!.authentication;
          String accessToken = googleSignInAuthentication.accessToken!;
          // await FirebaseMessaging.instance.getToken().then((token) async {
          //   print('token$googleUser');
          authBloc.add(SocialLoginSubmitted(
            googleUser.email,
            googleUser.displayName??"",
            // isSocialLogin: true,
            'google',
            // token: response.user!.uid ?? '',
            // deviceToken: token ?? '',
          ));
          // authBloc.add(SocialLoginButtonPressed(
          //   email: googleUser.email,
          //   firstName: googleUser.displayName!.split(' ').first,
          //   lastName: googleUser.displayName!.split(' ').last,
          //   isSocialLogin: true,
          //   provider: 'google',
          //   token: 'accessToken',
          //   deviceToken: token ?? '',
          // ));
          GoogleSignIn().disconnect();
        });
      }

    } on Exception catch (e) {
      print('error is ....... $e');
      // TODO
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  signInWithApple() async {
    //   print('token$token');
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    String? token = "";
    if (Platform.isAndroid) {
      token = await FirebaseMessaging.instance.getToken();
    } else {
      token = await FirebaseMessaging.instance.getAPNSToken();
    }
    var response =
    await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    authBloc.add(SocialLoginSubmitted(
      response.user?.email ?? ' ',
      response.user?.displayName??"",
      // isSocialLogin: true,
      'apple',
      // token: response.user!.uid ?? '',
      // deviceToken: token ?? '',
    ));
    print("${appleCredential.givenName} ${appleCredential.familyName}");

    GoogleSignIn().disconnect();
  }
}
