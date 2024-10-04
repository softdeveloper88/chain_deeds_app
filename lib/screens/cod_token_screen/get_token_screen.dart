import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/url_link.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GetTokensScreen extends StatefulWidget {
  const GetTokensScreen({super.key});

  @override
  State<GetTokensScreen> createState() => _GetTokensScreenState();
}

class _GetTokensScreenState extends State<GetTokensScreen> {
  double amount=0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor, // Light background color
      appBar: AppBar(
        backgroundColor: AppColors.backgroundScreenColor,
        elevation: 0,
        leading: InkWell(
            onTap: (){
              NavigatorService.goBack();
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,)),
        title: const Text('COD Tokens', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Token Purchase Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Amount of token you want to purchase',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        '=',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        'Token amount',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              '£10',
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              '1000',
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black,),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      onChanged: (amountValue){
                        setState(() {
                          if(amountValue !='') {
                            amount = double.parse(amountValue);
                          }else{
                            amount=0;
                          }
                        });
                      },
                      // controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        hintStyle: const TextStyle(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:  TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16.sp,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      ),
                    ),
                  ),
                  Text('You will get total token ${(amount*100).toStringAsFixed(2)}')
                ],
              ),
            ),


            const SizedBox(height: 32),
            // Donation Summary Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your donation',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your donation',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        '£10',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total due today',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        '£10',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: const TextSpan(
                      text: 'By choosing the payment method above, you agree to the ',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Mustard Deeds Terms of Service',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: ' and acknowledge the ',
                        ),
                        TextSpan(
                          text: 'Privacy Notice.',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // PayPal Button
            Center(
              child: MaterialButton(
                minWidth: 90.w,
                height: 50,
                onPressed: () {
                  UrlLink.launchURL(context,'${Constants.baseImageUrl}continue-tokens-ck?uid=${Constants.logInUserId}&a=${(amount*100)}');
                  // UrlLink.launchURL(context,Constants.baseImageUrl);
                },
                color:Colors.yellow[700] ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pay',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ), Text(
                      'Pal',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}