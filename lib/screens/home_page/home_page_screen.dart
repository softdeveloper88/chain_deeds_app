import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/constants.dart';
import 'package:chain_deeds_app/core/utils/shimmer_loader/shimmer_home_screen.dart';
import 'package:chain_deeds_app/model/home_model/home_model.dart';
import 'package:chain_deeds_app/screens/blog_screen/blog_screen.dart';
import 'package:chain_deeds_app/screens/campaign_screen/campaign_details_screen.dart';
import 'package:chain_deeds_app/screens/home_page/bloc/home_event.dart';
import 'package:chain_deeds_app/screens/shop_screen/product_list_screen.dart';
import 'package:chain_deeds_app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/convert_hex_color.dart';
import '../../widgets/mile_stone_card.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
            bloc: homeBloc,
            builder: (BuildContext context, HomeState state) {
              if (state is HomeLoading) {
                return ShimmerHomeScreen();
              } else if (state is HomeSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColors.customGreen,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Chain Of Deeds',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                MaterialButton(
                                  color: AppColors.customYellow,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {},
                                  child: const Text('Share Link',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12)),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('You are Number',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                                Text('${state.response.data?.chainNumber ?? 0}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Current Chain Number',
                                  style: TextStyle(fontSize: 16)),
                              const SizedBox(height: 8),
                              Text('${state.response.data?.chainNumber ?? 0}',
                                  style: const TextStyle(
                                      fontSize: 32, color: Colors.blue)),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                          itemCount: state.response.data?.campaigns?.length??0,
                          itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CampaignDetailsScreen(state.response.data?.campaigns?[index])));
                          },
                          child: MilestoneCard(
                            campaigns: state.response.data?.campaigns?[index],
                            buttonText: state.response.data?.campaigns?[index].displayStatus??'',
                            title: state.response.data?.campaigns?[index].title??'',
                            subtitle:state.response.data?.campaigns?[index].shortDescription??'',
                            progress: 0.62,
                            color: hexToColor(state.response.data?.campaigns?[index].bg??''),
                          ),
                        );
                      }),
                      BlogSection(state.response.data?.blogs ?? []),
                      ShopSection(state.response.data?.products ?? []),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }));
  }
}

class BlogSection extends StatelessWidget {
  BlogSection(this.blogs);

  List<Blogs>? blogs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('OUR BLOG',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 8),
            const Text(
              'Dive into our articles to discover firsthand accounts of how small acts of kindness are making a big difference in the world.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 16),
            // Carousel slider or a horizontal list
            SizedBox(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: blogs?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    width: 70.w,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      //   image: DecorationImage(
                      //     image: AssetImage('assets/images/blog_image.png'), // Replace with actual image
                      //     fit: BoxFit.cover,
                      //   ),
                    ),
                    child: Column(
                      // alignment: Alignment.bottomCenter,
                      children: [
                        Expanded(
                            child: CustomImageView(
                          imagePath:  blogs?[index].thumbnail??'',
                          height: 400,
                          fit: BoxFit.cover,
                          width: 70.w,
                        )),
                        Container(
                          width: 70.w,
                          color: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '5th April 2024',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      'Earth Future\nAct Today, Save Tomorrow.',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: AppColors.customYellow,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BlogScreen()));
                                },
                                child: const Text('Read'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 40,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: AppColors.customYellow,
                  onPressed: () {},
                  child: const Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  minWidth: 40,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: AppColors.customYellow,
                  onPressed: () {},
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShopSection extends StatelessWidget {
  ShopSection(this.productList);

  List<Products> productList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('OUR SHOP',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'With every purchase, you’re not just getting a quality product — you’re also supporting our community-driven movement to create positive change in the world.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...productList.map((product) {
                    return ProductCard(
                      productImage:'${product.thumbnail}',
                      productName: '${product.productName}',
                      price: '£ ${product.unitPrice}',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                     ProductListScreen()));
                      },
                    );
                  })
                ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 40,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: AppColors.customYellow,
                onPressed: () {},
                child: const Icon(Icons.arrow_back_ios),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                minWidth: 40,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: AppColors.customYellow,
                onPressed: () {},
                child: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final Function onTap;
  String productImage;
   ProductCard({
    required this.productName,
    required this.price,
    required this.onTap, required this.productImage ,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => onTap(),
            child: Material(
              elevation: 2,
              child: Container(
                width: 50.w,
                height: 200,
                color: Colors.grey.shade300,
                child: CustomImageView(
                 imagePath:  productImage,
                  fit: BoxFit.cover,
                ),
                // Replace with actual image
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(productName, style: const TextStyle(fontSize: 16)),
        Text(price,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
