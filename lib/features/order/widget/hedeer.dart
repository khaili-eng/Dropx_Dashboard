
import 'package:flutter/material.dart';
import 'package:maadati/core/constants/app_color/app_color.dart';
import 'package:maadati/core/respo/responsive.dart';
import 'package:maadati/features/order/widget/header_action_items.dart';



class Header extends StatelessWidget {

  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Maadati",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: AppColor.color4
                ),),
              Text("Dashboard",
                style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    color: AppColor.color3
                ),)
            ],
          ),
        ),
        Spacer(flex: 1,),
        Expanded(
            flex: Responsive.isDesktop(context)?1:3,
            child:TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.color1,
                  contentPadding: const EdgeInsets.only(left: 40,right: 5),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: AppColor.color4)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white)
                  ),
                  prefixIcon: const Icon(Icons.search,color: Colors.black,),
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: AppColor.color4,
                      fontSize: 14
                  )
              ),
            ),

        ),
        SizedBox(width: 110,),
        HeaderActionItems(),
      ],
    );
  }
}