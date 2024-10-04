import 'package:chain_deeds_app/core/utils/app_colors.dart';
import 'package:chain_deeds_app/core/utils/navigator_service.dart';
import 'package:chain_deeds_app/core/utils/shimmer_loader/common_shimmer_loading.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/bloc/cod_bloc.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/bloc/cod_event.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/create_edit_member_screen.dart';
import 'package:chain_deeds_app/screens/cod_token_screen/get_token_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'bloc/code_state.dart';

class AddEditMemberScreen extends StatefulWidget {
  @override
  State<AddEditMemberScreen> createState() => _AddEditMemberScreenState();
}

class _AddEditMemberScreenState extends State<AddEditMemberScreen> {
  CODBloc codBloc=CODBloc();
  @override
  void initState() {
    codBloc.add(GetMemberDataEvent());
    super.initState();
  }
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
        title: Row(
          children: [
            const Text('Add Edit Member', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateEditMembersScreen()));

              },
              child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.buttonSecondary,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Icon(Icons.add,color: Colors.white,size: 16,)),
            )
          ],
        ),
        centerTitle: false,
      ),
      body:  BlocBuilder<CODBloc, CODState>(
    bloc: codBloc,
    builder: (BuildContext context, CODState state) {
      if (state is CODLoading) {
        return const CommonShimmerLoading();
      } else if (state is CODSuccess) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: codBloc.getMemberModel?.data?.members?.length??0,
          itemBuilder: (context, index) {
            return transactionItem(codBloc.getMemberModel?.data?.members?[index].name??'', codBloc.getMemberModel?.data?.members?[index].relation??'', codBloc.getMemberModel?.data?.members?[index].email??"",
                codBloc.getMemberModel?.data?.members?[index].phone??'', () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateEditMembersScreen(members:codBloc.getMemberModel!.data!.members![index])));
                });
          },
        );
      }else{
        return Container();
      }
    }
    )

    );
  }

  Widget transactionItem(
      String name, String relation, String email, String phoneNumber,onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, color: Colors.black)),
                const SizedBox(height: 4),
                Text(relation, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            Column(
              children: [
                Text(email, style: const TextStyle(fontSize: 16, color: Colors.black)),
                Text(phoneNumber, style: const TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
            InkWell(
              onTap: ()=>onTap!(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text('Edit',
                    style:  TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}