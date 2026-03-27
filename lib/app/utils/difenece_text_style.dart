import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DifeneceTextStyle {
  // static const String font_default = 'Montserrat';
  static const String font_inter = 'Inter';
  static const String font_default = font_inter;

  static const TextStyle KH_BOLD = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 36, fontFamily: font_default);

  static const TextStyle KH_BOLD_1 = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 28, fontFamily: font_default);

  static const TextStyle KH_1 = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 20, fontFamily: font_default);

  static const TextStyle KH_2 = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 14, fontFamily: font_default);
  static const TextStyle KH_2_NORMAL = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, fontFamily: font_default);
  static const TextStyle KH_2_BOLD = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 12, fontFamily: font_default);
  static const TextStyle KH_3_BOLD2 = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 18, fontFamily: font_default);
  static const TextStyle KH_3_BOLD = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 12, fontFamily: font_default);
  static const TextStyle KH_4_BOLD = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 10, fontFamily: font_default);
  static const TextStyle KH_5_BOLD = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 14, fontFamily: font_default);
  static const TextStyle KH_6 = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, fontFamily: font_default);
  static const TextStyle KH_6_BOLD = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 12, fontFamily: font_default);
  static const TextStyle KH_7 = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 10, fontFamily: font_default);

  static const TextStyle KH_8 = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 8, fontFamily: font_default);
  static const TextStyle KH_8_NORMAL = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 8, fontFamily: font_default);
  static const TextStyle KH_8_BOLD = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 8, fontFamily: font_default);

  static const TextStyle INTER_BOLD_22 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    fontFamily: font_inter,
  );
  static const TextStyle INTER_BOLD_18 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    fontFamily: font_inter,
  );
  static const TextStyle INTER_MEDIUM_16 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    fontFamily: font_inter,
  );
  static const TextStyle INTER_REGULAR_14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontFamily: font_inter,
  );
  static const TextStyle INTER_LIGHT_12 = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    fontFamily: font_inter,
  );

  static const pageBackground =  BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFFFFFFF),
        Color(0x88FFDFDF),
        Color(0xE5FFDFDF),
        // 0%
        // 100%
      ],

    ),
  );

  // static final commenAppBar =  PreferredSize(
  //   preferredSize: const Size.fromHeight(140), // increase height
  //   child: AppBar(
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     automaticallyImplyLeading: false,
  //     flexibleSpace: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16),
  //         child:  Column(
  //           children: [
  //
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                   child: SvgPicture.asset("assets/app_logo.svg"),
  //                 ),
  //               ],
  //             ),
  //             Header(image: "assets/guard.png", name: "Manoj", position: "Guard", address: "Vision Rytham A wing Gate 1", date: "date"),
  //           ],
  //         ),
  //
  //       ),
  //     ),
  //   ),
  // );
}
