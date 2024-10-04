import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/convert_hex_color.dart';
import '../core/utils/app_colors.dart';
import '../model/home_model/home_model.dart';
import 'like_dislike_widget.dart';

class MilestoneCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final Color color;
  final String? buttonText;
  Campaigns?  campaigns;
  Function?  onTapDislike;
  Function?  onTapHeart;

   MilestoneCard({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.color,
    this.buttonText = 'Support',
    this.campaigns,
    this.onTapDislike,
    this.onTapHeart
  });

  @override
  Widget build(BuildContext context) {
    String buttonValue='';
    if(buttonText=='no_button'){
      buttonValue='';
    }else if(buttonText=='accepting_donation'){
      buttonValue='Accept Donation';
    }else{
      buttonValue='Contact Us';
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:setTextFitColor(color))),
              const SizedBox(height: 8),
              Text(subtitle, style:  TextStyle(fontSize: 16,color:setTextFitColor(color))),
              const SizedBox(height: 8),
              if(buttonText!='no_button') LinearProgressIndicator(value: double.parse(campaigns?.percentage??'0.0')/100,minHeight: 16,borderRadius: BorderRadius.circular(10),),
              if(buttonText!='no_button')  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${campaigns?.percentage??0}%",style: TextStyle(fontSize: 14,color:setTextFitColor(color)),),

                  Text(campaigns?.targetSupporters??'0',style: TextStyle(fontSize: 14,color:setTextFitColor(color)),)
                ],
              ),
              const SizedBox(height: 8),
              if(buttonText !='no_button')  const SizedBox(height: 8),
             if(buttonText !='no_button') MaterialButton(
                minWidth: 90.w,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color:isColorBlack(color) ? AppColors.customYellow:Colors.orange,
                onPressed: () {},
                // style: ElevatedButton.styleFrom( Colors.black),
                child: Text(buttonValue,style: const TextStyle(color: Colors.white),),
              ),
              const SizedBox(height: 8),
              if(buttonText !='no_button') Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LikeDislikeWidget(heartCounter: campaigns?.likes??0,dislikeCounter: campaigns?.unlikes??0,onTapDislike:()=>onTapDislike !=null?onTapDislike!():null,onTapHeart:()=> onTapHeart !=null?onTapHeart!():null,bgColor:isColorBlack(color) ? Colors.white54:Colors.black12,),
                  const SizedBox(width: 8,),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:isColorBlack(color)? Colors.white.withOpacity(0.3):Colors.black12.withOpacity(0.1)
                    ),
                    child:  Text('Share',style: TextStyle(fontSize: 14,color:setTextFitColor(color)),),

                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}