import 'package:chain_deeds_app/screens/authenatication_screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class AuthBottomSheetDialog {
  void show(BuildContext context,{
    required String text0,
    required String text1,
    required String text2,
    required String text3,
    Function? onTapGoogleLogin,
    Function? onTapAppleLogin,
  }) {

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * .4,
          child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03,
                        left: MediaQuery.of(context).size.width * 0.05),
                    child:  Text(
                      text0,
                      style:const  TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'TypoGraphica'),
                    ),
                  ), //text0
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width *
                          0.025, // Same multiplier for left
                      right: MediaQuery.of(context).size.width *
                          0.025, // Same multiplier for right
                    ),
                    child: MaterialButton(
                  elevation: 0,
                      onPressed: ()=>onTapAppleLogin!(),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child:  Center(
                            child: Text(
                          text1,
                          style:const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'BG Flame Bold'),
                        )),
                      ),
                    ),
                  ),//text1
                  Padding(
                    padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    left: MediaQuery.of(context).size.width *
                        0.025, // Same multiplier for left
                    right: MediaQuery.of(context).size.width *
                        0.025, // Same multiplier for right
                  ),
                    child: MaterialButton(
                  elevation: 0,
                      onPressed:()=>onTapGoogleLogin!(),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                       side: const BorderSide(
                        width: 1,
                         color: Colors.black,
                       )
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/ic_google.png",width: 20,height: 20,),
                            ),
                             Text(text2,style:
                             const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'BG Flame Bold'),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),//text2
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.width *
                          0.025, // Same multiplier for left
                      right: MediaQuery.of(context).size.width *
                          0.025, // Same multiplier for right
                    ),
                    child: MaterialButton(
                  elevation: 0,
                      onPressed: () {
                        switch(text3){
                          case "Log in with your e-mail":{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                          }
                          case "Sign Up with your e-mail":{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                          }
                        }

                      },
                      color: const Color(0xFFFFD319),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child:  Center(
                            child: Text(
                              text3,
                              style:const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'BG Flame Bold'),
                            )),
                      ),
                    ),
                  ),//text3
                ],
              )),
        );
      },
    );
  }
}
