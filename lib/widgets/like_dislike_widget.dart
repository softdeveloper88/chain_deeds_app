import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LikeDislikeWidget extends StatelessWidget {
   LikeDislikeWidget({this.dislikeCounter=0,this.heartCounter=0,this.onTapDislike,this.onTapHeart,this.bgColor=Colors.black12,super.key,});
 int? heartCounter=0;
 int? dislikeCounter=0;
 Function? onTapDislike;
 Function? onTapHeart;
 Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:  const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColor??Colors.black12
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              InkWell(
                  onTap:() =>onTapHeart!(),
                  child: SvgPicture.asset('assets/vectors/heart.svg')),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(heartCounter.toString()),
              ),
            ],
          ),
          const SizedBox(width: 10,),
          Container(color: Colors.black26,height: 20,width: 1,),
          const SizedBox(width: 10,),
          Row(
            children: [
              InkWell(
                  onTap:() =>onTapDislike!(),
                  child: SvgPicture.asset('assets/vectors/dislike.svg')),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(dislikeCounter.toString()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
