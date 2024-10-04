import 'package:chain_deeds_app/screens/authenatication_screens/bloc/auth_event.dart';
import 'package:chain_deeds_app/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../phone_screen/verification_code_screen.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';
import 'forgot_password_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
AuthBloc authBloc=AuthBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is AuthSuccess) {
              if (state.response['status']) {
                print('object');
               if(state.screen=="login" || state.screen=="social_login") {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Login successful!')),
                 );
                 if (state.response['data']['user']['phone_verified_at'] ==
                     null) {
                   Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) =>
                           VerificationCodeScreen(
                               isFrom: 'login',

                               onSubmit: (verified) {
                                 Navigator.pushReplacement(
                                     context, MaterialPageRoute(
                                     builder: (context) => const MainScreen()));
                               })));
                 } else {
                   Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) =>
                       const MainScreen()));
                 }
               }else{
                 ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.response['message'])),
                 );
               }
              } else {
                // _showErrorDialog(state.response['errors']);
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(state.response['message'])),
                );
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .15),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 25,
                        letterSpacing: -.1,
                        color: Colors.black,
                        fontFamily: 'TypoGraphica'),
                  ),
                ),
              ), //Login
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
                ), //detail text
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: -.1,
                      color: Colors.black,
                      fontFamily: 'TypoGraphica'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      color: const Color(0xfff5F9FC),
                      borderRadius: BorderRadius.circular(10)),
                  child:  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Type your email',
                      hintStyle: TextStyle(
                          fontFamily: 'BG Flame Light',
                          fontSize: 14,
                          color: Color(0xfffa8a8a8),
                          fontWeight: FontWeight.normal),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      // Adjust text padding
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 16,
                      letterSpacing: -.1,
                      color: Colors.black,
                      fontFamily: 'TypoGraphica'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      color: const Color(0xfff5F9FC),
                      borderRadius: BorderRadius.circular(10)),
                  child:  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Type your password',
                      hintStyle: TextStyle(
                          fontFamily: 'BG Flame Light',
                          fontSize: 14,
                          color: Color(0xfffa8a8a8),
                          fontWeight: FontWeight.normal),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      // Adjust text padding
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.62),
                child: TextButton(
                  onPressed: () {
                    ForgotPasswordDialog(authBloc).show(context);
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontFamily: 'BG Flame Light'),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Center(
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        if (
                            email.isEmpty || password.isEmpty) {
                          // Show error if any field is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("All fields are required.")));
                        } else {

                          authBloc.add(LoginSubmitted(email,password));
                        }
                      },
                      color: const Color(0xFFFFD319),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'BG Flame Bold'),
                            )),
                      ),
                    ),
                  );
                },
              ),

            ],
          )),
    );
  }
}
