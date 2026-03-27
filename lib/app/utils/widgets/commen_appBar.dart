import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../difenece_text_style.dart';
import 'global_widgets.dart';
import 'header.dart';

class CommenAppBar extends StatelessWidget {
  final String image;
  final String name;
  final String position;
  final String address;
  final String date;
  final BuildContext context;
  final bool isBottom;
  final bool? isDateSelect;
  final Widget child;
  final Widget? floatActions;
  const CommenAppBar({
    super.key,
    required this.image,
    required this.name,
    required this.position,
    required this.address,
    required this.date,
    required this.context,
     this.floatActions,
     this.isDateSelect,
    required this.child, required this.isBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: isBottom? true:false,
      // extendBodyBehindAppBar: isBottom? true:false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: isBottom? floatActions?? bottomNav():SizedBox(),
      appBar:  AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SvgPicture.asset("assets/app_logo.svg"),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Header(
                  image: image,
                  name: name,
                  position: position,
                  address: address,
                  isDateSelect: isDateSelect,
                  date: date,
                ),
              ],
            ),
          ),
        ),
      ),
      body:Container(
          width: double.infinity,
          height: double.infinity,
          decoration: DifeneceTextStyle.pageBackground,
          child: SafeArea(

              child: child)),
    );
  }
}
