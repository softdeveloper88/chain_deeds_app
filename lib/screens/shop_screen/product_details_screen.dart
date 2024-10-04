import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/shimmer_loader/shimmer_home_screen.dart';
import 'package:chain_deeds_app/screens/shop_screen/bloc/product_bloc.dart';
import 'package:chain_deeds_app/screens/shop_screen/bloc/product_event.dart';
import 'package:chain_deeds_app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:sizer/sizer.dart';

import 'bloc/product_state.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen(this.id);

  int? id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductBloc productBloc = ProductBloc();

  @override
  void initState() {
    productBloc.add(ProductDetailsEvent(widget.id ?? 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundScreenColor,
        appBar: AppBar(
          backgroundColor: Colors.blue[50],
          elevation: 0,
          leading: InkWell(
              onTap: () {
                NavigatorService.goBack();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              )),
          title: const Text('Shop',
              style: TextStyle(
                  fontFamily: 'TypoGraphica',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          centerTitle: false,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
            bloc: productBloc,
            builder: (BuildContext context, ProductState state) {
              if (state is ProductLoading) {
                return ShimmerHomeScreen();
              } else if (state is ProductSuccess) {
               return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CustomImageView(
                                 imagePath:productBloc.productDetailsModel?.data?.product?.attachment??'https://via.placeholder.com/300',
                                  // 'https://via.placeholder.com/300', // Replace with actual image URL
                                  height: 250,
                                  width: 90.w,
                                ),
                              ),
                              const SizedBox(height: 16),
                               Text(
                                productBloc.productDetailsModel?.data?.product?.productName??'',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily:
                                      "TypoGraphica", // Use custom font if required
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 24),
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 24),
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 24),
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 24),
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 24),
                                  SizedBox(width: 8),
                                  Text(
                                    '(23)',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                               Text(
                                '£${productBloc.productDetailsModel?.data?.product?.unitPrice?.toStringAsFixed(2)??0}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'SIZE',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: ['S', 'M', 'L', 'XL']
                                    .map(
                                      (size) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          // borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          size,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Info',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                               HtmlWidget(productBloc.productDetailsModel?.data?.product?.description??'',
                                // "Our mission isn't just about giving aid; it's about empowering individuals to create positive change in their own unique ways. We foster a culture of compassion and solidarity, where each member contributes their skills, time, and resources to build a better world. Together, we sow seeds of hope and empowerment, knowing that every small act of kindness can make a big impact. Join us in transforming intentions into deeds that inspire lasting change.",
                                // style: TextStyle(fontSize: 16, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          minWidth: 90.w,
                          height: 50,
                          color: Colors.black,
                          onPressed: () {
                            // Implement load more functionality
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                          child: const Text(
                            'Purchase',
                            style: TextStyle(
                              fontFamily: "TypoGraphica",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is ProductFailure) {
                return Text(state.error);
              }else {
                return Container(
                  child: const Text('data'),
                );
              }
            }));
  }
}
