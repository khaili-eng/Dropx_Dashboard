import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key, required this.mobile, this.tablet, required this.desktop});
  final Widget mobile;
    final Widget? tablet;
  final Widget desktop;
// static helper method to check if the current screen is a mobile device
  static bool isMobile(BuildContext context)=>
      MediaQuery.of(context).size.width<767;
  // static helper method to check if the current screen is a tablet device
  static bool isTablet(BuildContext context)=>
      MediaQuery.of(context).size.width<1024&& MediaQuery.of(context).size.width>=768;
  // static helper method to check if the current screen is a desktop device
  static bool isDesktop(BuildContext context)=>
      MediaQuery.of(context).size.width>=1025 ;
  @override
  Widget build(BuildContext context) {
       final Size size = MediaQuery.of(context).size;
   if(size.width>=1025){
     return desktop;
   }else if(size.width>=768 && tablet !=null){
     return tablet!;
   }else{
     //for all other screen
     return mobile;
   }
  }
  }

