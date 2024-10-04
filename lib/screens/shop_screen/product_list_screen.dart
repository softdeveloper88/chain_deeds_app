import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/shimmer_loader/shimmer_home_screen.dart';
import 'package:chain_deeds_app/screens/shop_screen/bloc/product_event.dart';
import 'package:chain_deeds_app/screens/shop_screen/product_details_screen.dart';
import 'package:chain_deeds_app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product_bloc.dart';
import 'bloc/product_state.dart';

class ProductListScreen extends StatefulWidget {
  ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductBloc productBloc = ProductBloc();

  @override
  void initState() {
    productBloc.add(ProductDataEvent());
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
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount:  productBloc.productsModel?.data?.products?.length??0,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        imageUrl: productBloc.productsModel?.data?.products?[index].thumbnail??'',
                        title: productBloc.productsModel?.data?.products?[index].productName??'',
                        price: '£${productBloc.productsModel?.data?.products?[index].unitPrice?.toStringAsFixed(2)??'0'}',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsScreen(productBloc.productsModel?.data?.products?[index].id)));
                        },
                      );
                    },
                  ),
                );
              } else if (state is ProductFailure) {
                return Text(state.error);
              }
              return Container();
            }));
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
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
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
                child:CustomImageView(
                  imagePath: imageUrl,
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
