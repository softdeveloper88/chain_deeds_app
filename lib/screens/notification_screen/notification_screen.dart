import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/screens/shop_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        elevation: 0,
        leading: InkWell(
            onTap: (){
              NavigatorService.goBack();
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,)),

        title: const Text('Notification',
            style: TextStyle(
                fontFamily: 'TypoGraphica',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return  Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child:const ListTile(title: Text("Token  from  Mohammad",style: TextStyle(color: Colors.black, fontFamily: 'TypoGraphica', fontWeight: FontWeight.normal,fontSize: 18),),subtitle: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since",style: TextStyle(fontFamily: 'BG Flame',fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black),
                )));
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final Function onTap;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Container(
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
          // boxShadow: [
          //   const BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 10.0,
          //     spreadRadius: 5.0,
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                child: Image.asset(
                  'assets/images/shirt.png',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'TypoGraphica', // Use custom font if required
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
