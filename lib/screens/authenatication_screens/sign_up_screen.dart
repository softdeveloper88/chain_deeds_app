import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chain_deeds_app/screens/authenatication_screens/bloc/auth_bloc.dart';
import 'package:chain_deeds_app/screens/authenatication_screens/bloc/auth_state.dart';
import 'package:chain_deeds_app/screens/main_screen/main_screen.dart';
import 'package:chain_deeds_app/screens/phone_screen/phone_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/show_error_dialog.dart';
import '../phone_screen/verification_code_screen.dart';
import 'bloc/auth_event.dart';
import 'error_dialog/error_dialog.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Create TextEditingControllers for each TextField
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();

  final TextEditingController _countryController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String countryCode = 'US';

  String dialCode = '+1';
  AuthBloc authBloc=AuthBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                              isFrom:  'signup',
                              phone:    _mobileController.text ?? '',
                              dialCode:  dialCode,
                              countryCode:  countryCode,onSubmit: (verified)
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .15),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 25,
                          wordSpacing: -2,
                          letterSpacing: -.1,
                          color: Colors.black,
                          fontFamily: 'TypoGraphica'),
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Your email and account information\nwill be protected",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'BG Flame Light',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                _buildLabel(context, "First Name"),
                _buildTextField(context, _firstNameController,
                    'Type your first name', TextInputType.name),
                const SizedBox(height: 30),
                _buildLabel(context, "Last Name"),
                _buildTextField(context, _lastNameController,
                    'Type your last name', TextInputType.name),
                const SizedBox(height: 30),
                _buildLabel(context, "Email"),
                _buildTextField(context, _emailController, 'Type your e-mail',
                    TextInputType.emailAddress),
                const SizedBox(height: 30),
                _buildLabel(context, "Username"),
                _buildTextField(context, _usernameController, 'Username',
                    TextInputType.text),
                const SizedBox(height: 30),
                _buildLabel(context, "Mobile No"),
                _buildPhoneTextField(context, _mobileController,
                    'Mobile Number', TextInputType.phone),
                const SizedBox(height: 30),
                _buildLabel(context, "Password"),
                _buildTextField(context, _passwordController, 'Password',
                    TextInputType.visiblePassword,
                    obscureText: true),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Use at least 8 characters with at least one number\none upper case and one lower case letter",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'BG Flame Light',
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "OR",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: -.1,
                      color: Colors.black,
                      fontFamily: 'TypoGraphica',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: MaterialButton(
                    elevation: 0,
                    onPressed: () {
                      onPressedGoogleLogin();
                      // Google sign-up logic
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          width: 1,
                          color: Colors.black,
                        )),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/ic_google.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const Text(
                            "Sign up with Google",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'BG Flame Bold'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "By continuing you agree to our\nterms and conditions",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'BG Flame Light',
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return buildSignupButton(context);
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ));
  }

  // Function to handle sign-up button press
  void _onSignUpPressed(BuildContext context) {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final username = _usernameController.text.trim();
    final mobile = _mobileController.text.trim();
    final password = _passwordController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        username.isEmpty ||
        mobile.isEmpty ||
        password.isEmpty) {
      // Show error if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All fields are required.")));
    } else {
      print(countryCode);
      authBloc.add(SignUpSubmitted(firstName, lastName,
          username, password, email,mobile, countryCode, dialCode));
    }
  }

  // Helper function to build labels
  Padding _buildLabel(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          letterSpacing: -.1,
          color: Colors.black,
          fontFamily: 'TypoGraphica',
        ),
      ),
    );
  }

  Widget buildSignupButton(context) {
    return Center(
      child: SizedBox(
        width: 90.w,
        child: ElevatedButton(
          onPressed: () {
            _onSignUpPressed(context);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            backgroundColor: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build TextFields
  Center _buildTextField(context, TextEditingController controller,
      String hintText, TextInputType keyboardType,
      {bool obscureText = false}) {
    return Center(
      child: Container(
        width: 90.w,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: const Color(0xfff5F9FC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'BG Flame Light',
              fontSize: 14,
              color: Color(0xfffa8a8a8),
              fontWeight: FontWeight.normal,
            ),
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Center _buildPhoneTextField(context, TextEditingController controller,
      String hintText, TextInputType keyboardType,
      {bool obscureText = false}) {
    return Center(
      child: Container(
        width: 90.w,
        padding: const EdgeInsets.only(top: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xfff5F9FC),
        ),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.grey),
            hintText: 'Mobile Number',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: const TextStyle(color: Colors.grey),
            prefixIcon: CountryCodePicker(
              onChanged: (countryCode1) {
                dialCode = countryCode1.dialCode ?? "+1";
                countryCode = countryCode1.code ?? "US";
              },
              initialSelection: 'US',
              favorite: const ['+1', 'US'],
              showCountryOnly: true,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
            ),
            filled: true,
            fillColor: const Color(0xfff5F9FC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
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
