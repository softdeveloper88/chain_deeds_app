import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/convert_date_time.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/add_edit_member_screen.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/bloc/cod_event.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/get_token_screen.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/send_token_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/shimmer_loader/common_shimmer_loading.dart';
import 'bloc/cod_bloc.dart';
import 'bloc/code_state.dart';

class CodTokenScreen extends StatefulWidget {
  @override
  State<CodTokenScreen> createState() => _CodTokenScreenState();
}

class _CodTokenScreenState extends State<CodTokenScreen> {
  CODBloc codBloc = CODBloc();

  @override
  void initState() {
    codBloc.add(CODDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundScreenColor,
        // Light background color
        appBar: AppBar(
          backgroundColor: AppColors.backgroundScreenColor,
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
          title: const Text('COD Tokens',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          centerTitle: false,
        ),
        body: BlocBuilder<CODBloc, CODState>(
            bloc: codBloc,
            builder: (BuildContext context, CODState state) {
              if (state is CODLoading) {
                return const CommonShimmerLoading();
              } else if (state is CODSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            elevation: 1,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const GetTokensScreen()));
                            },
                            minWidth: 90.w,
                            color: AppColors.buttonSecondary,
                            // Get Tokens button color
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Get Tokens',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MaterialButton(
                              elevation: 1,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddEditMemberScreen()));
                              },
                              minWidth: 50.w,
                              color: Colors.yellow[700],
                              // Get Tokens button color
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Add/ Edit Members',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.sp),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: MaterialButton(
                              elevation: 1,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SendTokenScreen()));
                              },
                              minWidth: 50.w,
                              color: Colors.orange[600],
                              // Get Tokens button color
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Send Token',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Middle Section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Token Available',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Text('${codBloc.codTokenModel?.data?.tokenAvailable??'0'}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Transaction History Section
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Transactions history',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text('Full history',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: codBloc.codTokenModel?.data?.transactions?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return transactionItem(codBloc.codTokenModel?.data?.transactions?[index].userName??'',
                                      codBloc.codTokenModel?.data?.transactions?[index].createdAt??"",codBloc.codTokenModel?.data?.transactions?[index].tokens.toString()??'' , '221');
                                  }))),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }));
  }

  Widget transactionItem(String name, String date, String code, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              const SizedBox(height: 4),
              Text(date,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          Text(code, style: const TextStyle(fontSize: 16, color: Colors.black)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(amount,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
